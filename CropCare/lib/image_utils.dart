import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<Uint8List> preprocessImage(
    File imageFile, int inputSize, int height) async {
  final rawImage = img.decodeImage(await imageFile.readAsBytes());

  if (rawImage == null) {
    throw Exception('Error decoding the image file');
  }
  final resizedImage =
      img.copyResize(rawImage, width: inputSize, height: inputSize);
  final input = Float32List(inputSize * inputSize * 3);
  int pixelIndex = 0;

  for (int y = 0; y < inputSize; y++) {
    for (int x = 0; x < inputSize; x++) {
      final pixel = resizedImage.getPixel(x, y);
      final int pixelValue = pixel as int;
      final r = (pixelValue >> 16) & 0xFF;
      final g = (pixelValue >> 8) & 0xFF;
      final b = pixelValue & 0xFF;

      input[pixelIndex++] = r / 255.0;
      input[pixelIndex++] = g / 255.0;
      input[pixelIndex++] = b / 255.0;
    }
  }

  return input.buffer.asUint8List();
}
