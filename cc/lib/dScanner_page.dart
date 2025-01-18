import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'base_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'prediction_page.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class DScannerPage extends StatefulWidget {
  @override
  _DScannerPageState createState() => _DScannerPageState();
}

class _DScannerPageState extends State<DScannerPage> {
  int _selectedIndex = 0;
  File? _image;
  bool _modelLoaded = false;
  late Interpreter _interpreter;
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  bool _isImageCaptured = false;

  final List<String> _diseaseLabels = [
    'Corn Cercospora Leaf Spot',
    'Corn Common Rust',
    'Corn Healthy',
    'Potato Early Blight',
    'Potato Late Blight',
    'Potato Healthy',
    'Tomato Early Blight',
    'Tomato Late Blight',
    'Tomato Yellow Leaf Curl Virus',
    'Tomato Mosaic Virus',
    'Tomato Healthy'
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
    _checkPermissions();
    _initializeCamera();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
          'assets/CropCare_mobilenetv3small.tflite');
      setState(() {
        _modelLoaded = true;
      });
      print("Model loaded successfully.");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _checkPermissions() async {
    PermissionStatus cameraPermission = await Permission.camera.request();
    PermissionStatus storagePermission = await Permission.photos.request();
    PermissionStatus notificationPermission =
        await Permission.notification.request();

    if (cameraPermission.isDenied ||
        storagePermission.isDenied ||
        notificationPermission.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Camera, storage, and notification permissions are required!')));
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameras = cameras;

    if (_cameras.isNotEmpty) {
      _cameraController = CameraController(
        _cameras[0],
        ResolutionPreset.medium,
      );

      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> _captureImage() async {
    try {
      final cameraImage = await _cameraController.takePicture();
      setState(() {
        _image = File(cameraImage.path);
        _isImageCaptured = true;
      });
    } catch (e) {
      print("Error capturing image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error capturing image!')),
      );
    }
  }

  Future<void> _importImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isImageCaptured = true;
      });
    }
  }

  Future<List<List<List<List<int>>>>> preprocessImage(
      File imageFile, int width, int height) async {
    final bytes = await imageFile.readAsBytes();
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

    final resizedImage = img.copyResize(image, width: width, height: height);

    List<List<List<List<int>>>> processedImage = List.generate(
      1,
      (batchIndex) => List.generate(
        height,
        (y) => List.generate(width, (x) => List.filled(3, 0), growable: false),
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

  Future<void> _predictDisease() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select or capture an image first!')),
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

      int maxIndex =
          output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

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
    _cameraController.dispose();
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode (light or dark)
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return BasePage(
      title: 'Disease Scanner',
      selectedIndex: _selectedIndex,
      onItemTapped: (index) => setState(() => _selectedIndex = index),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isImageCaptured)
              Image.file(
                _image!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              )
            else if (_isCameraInitialized)
              SizedBox(
                width: 250,
                height: 250,
                child: CameraPreview(_cameraController),
              )
            else
              const CircularProgressIndicator(),

            const SizedBox(height: 20),

            // Capture Image Button with Camera Icon
            IconButton(
              onPressed: _captureImage,
              icon: const Icon(Icons.camera_alt),
              iconSize: 80,
              color: Color(0xFF0A8484),
            ),

            const SizedBox(height: 20),

            // Import Image Button with Gallery Icon and Text
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _importImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Import Image from Gallery',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: isLightMode ? Colors.white : Colors.black,
                  onPrimary: isLightMode ? Colors.black : Colors.white, // Text color
                  side: const BorderSide(color: Color(0xFF0A8484), width: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Scan and Predict Button with Styled Border and Size
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _predictDisease,
                child: const Text(
                  'Predict',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: isLightMode ? Colors.white : Colors.black,
                  onPrimary: isLightMode ? Colors.black : Colors.white, // Text color
                  side: const BorderSide(color: Color(0xFF0A8484), width: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}