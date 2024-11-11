import 'package:flutter/material.dart';

class HighlightStyle {
  final bool sizeLarge;
  final Color? background;
  final Color? color;
  final bool? isHexagon;
  final double? elevation;
  final int? customSize;

  const HighlightStyle({
    this.sizeLarge = false,
    this.isHexagon = false,
    this.background,
    this.color,
    this.elevation,
    this.customSize,
  });
}
