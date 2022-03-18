import 'package:flutter/material.dart';

class TextInputDecorations {
  static InputDecoration defaultTextInputDecoration(
    TextStyle style,
    String? hint, {
    String? prefixText,
  }) =>
      InputDecoration(
        hintStyle: style,
        hintText: hint,
        hintMaxLines: 1,
        border: InputBorder.none,
        prefixText: prefixText,
      );
}
