import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

// Function to load image and convert it to base64 string
Future<String> getPureBase64String(String assetPath) async {
  final ByteData byteData = await rootBundle.load(assetPath);
  final Uint8List bytes = byteData.buffer.asUint8List();

  // Base64 encoding and fixing padding issues
  String base64String = base64Encode(bytes);

  // Ensure proper padding in base64 string (length must be multiple of 4)
  int paddingLength = base64String.length % 4;
  if (paddingLength != 0) {
    base64String = base64String.padRight(base64String.length + (4 - paddingLength), '=');
  }

  return base64String;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Get the pure base64 string for the asset image
    final String pureBase64 = await getPureBase64String("assets/images/dpimages/dp5.jpeg");

    // 1. Print the base64 string to copy into Firebase
    print("COPY THIS EXACT STRING:");
    print(pureBase64);

  } catch (e) {
    print("Error: $e");
  }
}
