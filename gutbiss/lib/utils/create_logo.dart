import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async {
  // Create a simple logo
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  
  // Draw a circle with an icon
  final paint = Paint()
    ..color = Colors.deepOrange;
  
  canvas.drawCircle(const Offset(512, 512), 512, paint);
  
  // Save the image
  final picture = recorder.endRecording();
  final img = await picture.toImage(1024, 1024);
  final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
  
  // Write to file
  File('assets/icons/app_logo.png').writeAsBytesSync(pngBytes!.buffer.asUint8List());
} 