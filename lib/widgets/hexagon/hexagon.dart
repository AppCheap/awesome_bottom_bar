import 'dart:math';

import 'package:flutter/material.dart';

import 'hexagon_clipper.dart';
import 'hexagon_painter.dart';
import 'hexagon_path_builder.dart';

double ratio = (sqrt(3) / 2);

class HexagonWidget extends StatelessWidget {
  const HexagonWidget({
    Key? key,
    this.width = 48,
    this.height = 48,
    required this.color,
    this.child,
    this.padding = 0,
    this.cornerRadius = 14,
    this.elevation = 0,
    this.inBounds = true,
  })  : assert(elevation >= 0),
        super(key: key);

  final double width;
  final double height;
  final double elevation;
  final bool inBounds;
  final Widget? child;
  final Color color;
  final double padding;
  final double cornerRadius;

  Size? _innerSize() {
    return Size(width, height);
  }

  Size? _contentSize() {
    return Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    var innerSize = _innerSize();
    var contentSize = _contentSize();

    HexagonPathBuilder pathBuilder = HexagonPathBuilder(inBounds: inBounds, borderRadius: cornerRadius);

    return Align(
      child: Container(
        padding: EdgeInsets.all(padding),
        width: innerSize?.width,
        height: innerSize?.height,
        child: CustomPaint(
          painter: HexagonPainter(
            pathBuilder,
            color: color,
            elevation: elevation,
          ),
          child: ClipPath(
            clipper: HexagonClipper(pathBuilder),
            child: OverflowBox(
              alignment: Alignment.center,
              maxHeight: contentSize?.height,
              maxWidth: contentSize?.width,
              child: Align(
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
