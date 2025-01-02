import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // Using tflite_flutter
import 'base_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img; // Image library for preprocessing

class DScannerPage extends StatefulWidget {
  @override
  _DScannerPageState createState() => _DScannerPageState();
}

class _DScannerPageState extends State<DScannerPage> {
  int _selectedIndex = 0; // Track the selected index for navigation
  File? _image; // Store the selected or captured image file
  bool _modelLoaded = false; // Flag to track model loading status
  late Interpreter _interpreter; // Declare Interpreter variable

  // Disease labels (assuming there are 11 classes as in your output size)
  final List<String> _diseaseLabels = [ 
    'Corn Cercospora Leaf Spot', 'Corn Common Rust', 'Corn Healthy', 'Potato Early Blight', 'Potato Late Blight',  
    'Potato Healthy', 'Tomato Early Blight', 'Tomato Late Blight', 'Tomato Yellow Leaf Curl Virus', 'Tomato Mosaic Virus', 'Tomato Healthy' 
  ];

  // Function to handle tapping on the bottom navigation items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index when an item is tapped
    });
  }

  @override
  void initState() {
    super.initState();
    _loadModel(); // Load the TFLite model on initialization
    _checkPermissions(); // Check permissions on app start
  }

  // Function to load the TFLite model using tflite_flutter
  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/CropCare_mobilenetv3small.tflite');
      setState(() {
        _modelLoaded = true; // Update flag when model is loaded
      });
      print("Model loaded successfully.");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  // Function to check and request permissions for camera, gallery, and notifications
  Future<void> _checkPermissions() async {
    PermissionStatus cameraPermission = await Permission.camera.request();
    PermissionStatus storagePermission = await Permission.photos.request();
    PermissionStatus notificationPermission = await Permission.notification.request();

    if (cameraPermission.isDenied || storagePermission.isDenied || notificationPermission.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera, storage, and notification permissions are required!'))
      );
    }
  }

  // Function to capture or import an image
  Future<void> _captureOrImportImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the state with the selected image
      });
    }
  }

  // Function to preprocess the image and convert it into the correct input format
  Future<List<List<List<List<int>>>>> preprocessImage(File imageFile, int width, int height) async {
    // Read the image from the file
    final bytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

    // Resize the image to the desired input size for the model
    final resizedImage = img.copyResize(image, width: width, height: height);

    // Initialize the processedImage list to match the expected input format
    List<List<List<List<int>>>> processedImage = List.generate(
      1, // This represents the batch size of 1
      (batchIndex) => List.generate(
        height, 
        (y) => List.generate(
          width, 
          (x) => List.filled(3, 0), // RGB values
          growable: false
        ),
        growable: false,
      ),
      growable: false,
    );

    // Populate the processedImage with RGB values from the resized image
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        img.Pixel pixel = resizedImage.getPixel(x, y);
        processedImage[0][y][x][0] = pixel.r.toInt(); // Red channel
        processedImage[0][y][x][1] = pixel.g.toInt(); // Green channel
        processedImage[0][y][x][2] = pixel.b.toInt(); // Blue channel
      }
    }

    // Return the image in the expected 4D tensor format
    return processedImage;
  }

  // Function to predict disease using the selected image
  Future<void> _predictDisease() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or capture an image first!')),
      );
      return;
    }

    if (!_modelLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model is not loaded yet!')),
      );
      return;
    }

    try {
      // Preprocess image with width and height values for the model input size
      int width = 224;  // Set the input width expected by your model
      int height = 224; // Set the input height expected by your model

      // Pass the image, width, and height to the preprocessImage function
      var inputImage = await preprocessImage(_image!, width, height);

      var output = List.generate(1, (i) => List.filled(11, 0.0));

      _interpreter.run(inputImage, output);
      print("Prediction output: $output");

      // Find the index of the highest probability
      int maxIndex = output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

      // Get the disease name corresponding to the highest probability
      String predictedDisease = _diseaseLabels[maxIndex];

      if (output.isNotEmpty) {
        _showPredictionDialog("Predicted disease: $predictedDisease");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No disease detected!')),
        );
      }
    } catch (e) {
      print("Error during prediction: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prediction failed!')),
      );
    }
  }

  // Function to display the prediction result in a dialog
  void _showPredictionDialog(String predictedDisease) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Prediction Result'),
          content: Text(predictedDisease),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _interpreter.close(); // Close the interpreter to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Disease Scanner',
      selectedIndex: _selectedIndex, // Pass the selectedIndex
      onItemTapped: _onItemTapped,  // Pass the onItemTapped function
      child: Center( // Pass the child as a parameter
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : const Text("No image selected"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _captureOrImportImage(ImageSource.camera),
              child: const Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: () => _captureOrImportImage(ImageSource.gallery),
              child: const Text('Import from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictDisease,
              child: const Text('Scan and Predict'),
            ),
          ],
        ),
      ),
    );
  }
}
