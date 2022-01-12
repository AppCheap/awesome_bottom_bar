import 'dart:math';
import 'dart:ui';

class HexagonPathBuilder {
  final bool inBounds;
  final double borderRadius;

  HexagonPathBuilder({this.inBounds = true, this.borderRadius = 10});

  Path build(Size size) => _hexagonPath(size);

  Point _pointyHexagonCorner(Offset center, double size, int i) {
    var angleDeg = 60 * i - 30;
    var angleRad = pi / 180 * angleDeg;
    return Point(center.dx + size * cos(angleRad), center.dy + size * sin(angleRad));
  }

  /// Calculates hexagon corners for given size and center.
  List<Point> _pointyHexagonCornerList(Offset center, double size) => List<Point>.generate(
        6,
        (index) => _pointyHexagonCorner(center, size, index),
        growable: false,
      );

  Point _pointBetween(Point start, Point end, {double? distance, double? fraction}) {
    double xLength = (end.x - start.x).toDouble();
    double yLength = (end.y - start.y).toDouble();
    if (fraction == null) {
      if (distance == null) {
        throw Exception('Distance or fraction should be specified.');
      }
      double length = sqrt(xLength * xLength + yLength * yLength);
      fraction = distance / length;
    }
    return Point(start.x + xLength * fraction, start.y + yLength * fraction);
  }

  Point _radiusStart(Point corner, int index, List<Point> cornerList, double radius) {
    Point prevCorner = index > 0 ? cornerList[index - 1] : cornerList[cornerList.length - 1];
    double distance = radius * tan(pi / 6);
    return _pointBetween(corner, prevCorner, distance: distance);
  }

  Point _radiusEnd(Point corner, int index, List<Point> cornerList, double radius) {
    Point nextCorner = index < cornerList.length - 1 ? cornerList[index + 1] : cornerList[0];
    double distance = radius * tan(pi / 6);
    return _pointBetween(corner, nextCorner, distance: distance);
  }

  /// Returns path in shape of hexagon.
  Path _hexagonPath(Size size) {
    var inBounds = this.inBounds == true;
    var borderRadius = this.borderRadius;
    final center = Offset(size.width / 2, size.height / 2);

    List<Point> cornerList;
    double pointyFactor = !inBounds ? 0.75 : 1;
    cornerList = _pointyHexagonCornerList(center, size.height / pointyFactor / 2);

    final path = Path();
    if (borderRadius > 0) {
      Point rStart;
      Point rEnd;
      cornerList.asMap().forEach((index, point) {
        rStart = _radiusStart(point, index, cornerList, borderRadius);
        rEnd = _radiusEnd(point, index, cornerList, borderRadius);
        if (index == 0) {
          path.moveTo(rStart.x.toDouble(), rStart.y.toDouble());
        } else {
          path.lineTo(rStart.x.toDouble(), rStart.y.toDouble());
        }
        // rough approximation of an circular arc for 120 deg angle.
        Point control1 = _pointBetween(rStart, point, fraction: 0.7698);
        Point control2 = _pointBetween(rEnd, point, fraction: 0.7698);
        path.cubicTo(
          control1.x.toDouble(),
          control1.y.toDouble(),
          control2.x.toDouble(),
          control2.y.toDouble(),
          rEnd.x.toDouble(),
          rEnd.y.toDouble(),
        );
      });
    } else {
      cornerList.asMap().forEach((index, point) {
        if (index == 0) {
          path.moveTo(point.x.toDouble(), point.y.toDouble());
        } else {
          path.lineTo(point.x.toDouble(), point.y.toDouble());
        }
      });
    }

    return path..close();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexagonPathBuilder &&
          runtimeType == other.runtimeType &&
          inBounds == other.inBounds &&
          borderRadius == other.borderRadius;

  @override
  int get hashCode => inBounds.hashCode ^ borderRadius.hashCode;
}
