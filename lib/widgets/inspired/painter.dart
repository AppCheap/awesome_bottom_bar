/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:flutter/material.dart';

import 'convex_shape.dart';
import 'inspired.dart';

/// Custom painter to draw the [ConvexNotchedRectangle] into canvas.
class ConvexPainter extends CustomPainter {
  final _paint = Paint();
  final _shadowPaint = Paint();
  late ConvexNotchedRectangle _shape;

  /// Width of the convex shape.
  final double width;

  /// Height of the convex shape.
  final double height;

  /// Position in vertical which describe the offset of shape.
  final double top;

  /// Position in horizontal which describe the offset of shape.
  final Animation<double> leftPercent;

  /// RLT support
  final TextDirection? textDirection;

  final bool isHexagon;

  final bool outside;

  final bool drawHexagon;
  final bool convexBridge;

  final NotchSmoothness notchSmoothness;

  final double leftCornerRadius;
  final double rightCornerRadius;

  /// Create painter
  ConvexPainter({
    required this.top,
    required this.width,
    required this.height,
    required this.notchSmoothness,
    this.leftPercent = const AlwaysStoppedAnimation<double>(0.5),
    this.textDirection,
    Color color = Colors.white,
    Color shadowColor = const Color.fromRGBO(0, 0, 0, 0.06),
    double sigma = 2,
    Gradient? gradient,
    this.isHexagon = false,
    this.outside = false,
    this.drawHexagon = false,
    this.convexBridge = false,
    this.leftCornerRadius = 0,
    this.rightCornerRadius = 0,
  }) : super(repaint: leftPercent) {
    _paint.color = color;
    try {
      _shadowPaint
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.outer, sigma);
    } catch (e, s) {
      debugPrintStack(label: 'ElevationError', stackTrace: s);
    }
    _shape = ConvexNotchedRectangle(
      isHexagon: isHexagon,
      drawHexagon: drawHexagon,
      notchSmoothness: notchSmoothness,
      convexBridge: convexBridge,
      leftCornerRadius: leftCornerRadius,
      rightCornerRadius: rightCornerRadius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    var host = Rect.fromLTWH(0, 0, size.width, size.height);
    var percent = textDirection == TextDirection.rtl ? (1 - leftPercent.value) : leftPercent.value;
    var guest = Rect.fromLTWH(size.width * percent - width / 2, top, width, height);
    var path = _shape.getOuterPath(host, guest);
    canvas.drawPath(path, _shadowPaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(ConvexPainter oldDelegate) {
    return oldDelegate.leftPercent.value != leftPercent.value || oldDelegate._paint != _paint;
  }
}
