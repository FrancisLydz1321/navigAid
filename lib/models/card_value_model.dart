import 'package:flutter/material.dart';

class CardValue {
  final String image;
  final String text;
  final Widget? screen;

  CardValue({
    required this.image,
    required this.text,
    this.screen,
  });
}
