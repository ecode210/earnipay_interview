import 'package:flutter/material.dart';

extension HexColor on Color {
  /// Converts Hex color code from String to Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension StringExtension on String {
  /// Capitalizes first letter of the first word of every sentence in a String
  String get capitalizeFirstWord {
    String value = "";
    List<String> sentences = split(".");
    for (String sentence in sentences) {
      value = "$value${sentence[0].toUpperCase()}${sentence.substring(1).toLowerCase()}.";
    }
    return value;
  }
}
