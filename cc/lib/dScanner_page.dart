import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // Using tflite_flutter
import 'base_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img; // Image library for preprocessing
import 'dInfoData.dart';
import 'prediction_page.dart'; // Import PredictionPage

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
    final bytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

    final resizedImage = img.copyResize(image, width: width, height: height);

    List<List<List<List<int>>>> processedImage = List.generate(
      1, 
      (batchIndex) => List.generate(
        height, 
        (y) => List.generate(
          width, 
          (x) => List.filled(3, 0), 
          growable: false
        ),
        growable: false,
      ),
      growable: false,
    );

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        img.Pixel pixel = resizedImage.getPixel(x, y);
        processedImage[0][y][x][0] = pixel.r.toInt();
        processedImage[0][y][x][1] = pixel.g.toInt();
        processedImage[0][y][x][2] = pixel.b.toInt();
      }
    }

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
      int width = 224;
      int height = 224;

      var inputImage = await preprocessImage(_image!, width, height);
      var output = List.generate(1, (i) => List.filled(11, 0.0));

      _interpreter.run(inputImage, output);

      int maxIndex = output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

      String predictedDisease = _diseaseLabels[maxIndex];

      if (output.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PredictionPage(
              image: _image!,
              predictedDisease: predictedDisease,
              predictionScores: output[0],
              highestScore: output[0][maxIndex],
            ),
          ),
        );
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

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Disease Scanner',
      selectedIndex: _selectedIndex,
      onItemTapped: (index) => setState(() => _selectedIndex = index),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null ? Image.file(_image!) : const Text("No image selected"),
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
