import 'package:flutter/material.dart';

import 'hexagon_path_builder.dart';

/// This class is responsible for painting HexagonWidget color and shadow in proper shape.
class HexagonPainter extends CustomPainter {
  HexagonPainter(this.pathBuilder, {required this.color, this.elevation});

  final HexagonPathBuilder pathBuilder;
  final double? elevation;
  final Color color;

  final Paint _paint = Paint();
  Path _path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = color;
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;

    _path = pathBuilder.build(size);

    if ((elevation ?? 0) > 0) canvas.drawShadow(_path, Colors.black, elevation ?? 0, false);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool hitTest(Offset position) {
    return _path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexagonPainter &&
          runtimeType == other.runtimeType &&
          pathBuilder == other.pathBuilder &&
          elevation == other.elevation &&
          color == other.color;

  @override
  int get hashCode => pathBuilder.hashCode ^ elevation.hashCode ^ color.hashCode;
}
