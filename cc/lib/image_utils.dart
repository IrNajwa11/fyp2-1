import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Loads and processes the image file to be used as input for the model.
Future<Uint8List> preprocessImage(File imageFile, int inputSize, int height) async {
  // Read the image from the file
  final rawImage = img.decodeImage(await imageFile.readAsBytes());

  // Ensure the image was decoded successfully
  if (rawImage == null) {
    throw Exception('Error decoding the image file');
  }

  // Resize the image to the required input size
  final resizedImage = img.copyResize(rawImage, width: inputSize, height: inputSize);

  // Prepare a list to store pixel data
  final input = Float32List(inputSize * inputSize * 3);
  int pixelIndex = 0;

  // Process each pixel and extract the RGB values
  for (int y = 0; y < inputSize; y++) {
    for (int x = 0; x < inputSize; x++) {
      final pixel = resizedImage.getPixel(x, y);

      // Convert the pixel value to an integer
      final int pixelValue = pixel as int;

      // Extract the RGB components using bit shifts
      final r = (pixelValue >> 16) & 0xFF; // Red component
      final g = (pixelValue >> 8) & 0xFF;  // Green component
      final b = pixelValue & 0xFF;         // Blue component

      // Normalize the values by dividing by 255.0
      input[pixelIndex++] = r / 255.0;
      input[pixelIndex++] = g / 255.0;
      input[pixelIndex++] = b / 255.0;
    }
  }

  // Return the pixel data as a Uint8List (used for model input)
  return input.buffer.asUint8List();
}
