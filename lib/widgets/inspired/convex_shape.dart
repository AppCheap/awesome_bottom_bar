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

import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter/animation.dart';
import 'inspired.dart';

class ConvexNotchedRectangle extends NotchedShape {
  final NotchSmoothness notchSmoothness;
  final bool isHexagon;
  final bool drawHexagon;
  final bool convexBridge;
  final double leftCornerRadius;
  final double rightCornerRadius;
  final Animation<double>? animation;

  ConvexNotchedRectangle({
    required this.notchSmoothness,
    this.isHexagon = false,
    this.drawHexagon = false,
    this.convexBridge = false,
    this.leftCornerRadius = 0,
    this.rightCornerRadius = 0,
    this.animation,
  });

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    double notchRadius = guest.width / 2.0;

    final double s1 = notchSmoothness.s1;
    final double s2 = notchSmoothness.s2;

    double r = notchRadius;
    double a = -1.0 * r - s2;
    double b = host.top - guest.center.dy;

    double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    double p2yA = convexBridge ? -math.sqrt(r * r - p2xA * p2xA) : math.sqrt(r * r - p2xA * p2xA);
    double p2yB = convexBridge ? -math.sqrt(r * r - p2xB * p2xB) : math.sqrt(r * r - p2xB * p2xB);

    List<Offset> p = List.filled(6, Offset.zero, growable: true);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i] + guest.center;
    }

    double leftCornerRadius = this.leftCornerRadius * (animation?.value ?? 1);
    double rightCornerRadius = this.rightCornerRadius * (animation?.value ?? 1);
    if (isHexagon) {
      return Path()
        ..moveTo(host.left, host.top)
        ..lineTo(host.left, host.top + leftCornerRadius)
        ..arcToPoint(
          Offset(host.left + leftCornerRadius, host.top),
          radius: Radius.circular(leftCornerRadius),
          clockwise: true,
        )
        ..lineTo(p[0].dx, p[0].dy)
        ..lineTo(p[1].dx, p[1].dy)
        ..lineTo(p[4].dx, p[4].dy)
        ..lineTo(host.right, host.top)
        ..lineTo(host.right - rightCornerRadius, host.top)
        ..arcToPoint(
          Offset(host.right, host.top + rightCornerRadius),
          radius: Radius.circular(rightCornerRadius),
          clockwise: true,
        )
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..moveTo(p[0].dx + 20, p[0].dy)
        ..conicTo(p[1].dx + 41, p[1].dy - 23, p[4].dx - 5, p[4].dy, 10)
        ..close();
    }
    if (drawHexagon) {
      return Path()
        ..moveTo(host.left, host.top)
        ..lineTo(host.left, host.bottom)
        ..lineTo(host.left, host.top + leftCornerRadius)
        ..arcToPoint(
          Offset(host.left + leftCornerRadius, host.top),
          radius: Radius.circular(leftCornerRadius),
          clockwise: true,
        )
        ..lineTo(p[2].dx + 4, host.top)
        ..conicTo(p[2].dx + 4, 2 * p[2].dy * 5.2 / 4, p[3].dx - 36, p[3].dy * 4.6, 6)
        ..quadraticBezierTo(p[3].dx - 38, p[3].dy * 4.6, p[3].dx - 32, p[3].dy * 4.6)
        ..conicTo(p[4].dx - 6.5, 2 * p[2].dy * 5.2 / 4, p[5].dx - 22, p[5].dy, 6)
        ..lineTo(host.right - rightCornerRadius, host.top)
        ..arcToPoint(
          Offset(host.right, host.top + rightCornerRadius),
          radius: Radius.circular(rightCornerRadius),
          clockwise: true,
        )
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();
    }
    if (convexBridge) {
      return Path()
        ..moveTo(host.left, host.top)
        ..lineTo(host.left, host.top + leftCornerRadius)
        ..arcToPoint(
          Offset(host.left + leftCornerRadius, host.top),
          radius: Radius.circular(leftCornerRadius),
          clockwise: true,
        )
        ..lineTo(p[0].dx, p[0].dy)
        ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
        ..arcToPoint(
          p[3],
          radius: Radius.circular(notchRadius),
          clockwise: true,
        )
        ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
        ..lineTo(host.right - rightCornerRadius, host.top)
        ..arcToPoint(
          Offset(host.right, host.top + rightCornerRadius),
          radius: Radius.circular(rightCornerRadius),
          clockwise: true,
        )
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();
    }
    return Path()
      ..moveTo(host.left, host.bottom)
      ..lineTo(host.left, host.top)
      ..lineTo(host.left, host.top + leftCornerRadius)
      ..arcToPoint(
        Offset(host.left + leftCornerRadius, host.top),
        radius: Radius.circular(leftCornerRadius),
        clockwise: true,
      )
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius - 1),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - rightCornerRadius, host.top)
      ..arcToPoint(
        Offset(host.right, host.top + rightCornerRadius),
        radius: Radius.circular(rightCornerRadius),
        clockwise: true,
      )
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}

extension on NotchSmoothness? {
  static const curveS1 = {
    NotchSmoothness.sharpEdge: 0.0,
    NotchSmoothness.defaultEdge: 15.0,
    NotchSmoothness.softEdge: 20.0,
    NotchSmoothness.smoothEdge: 30.0,
    NotchSmoothness.verySmoothEdge: 40.0,
  };

  static const curveS2 = {
    NotchSmoothness.sharpEdge: 0.1,
    NotchSmoothness.defaultEdge: 1.0,
    NotchSmoothness.softEdge: 5.0,
    NotchSmoothness.smoothEdge: 15.0,
    NotchSmoothness.verySmoothEdge: 25.0,
  };

  double get s1 => curveS1[this] ?? 15.0;

  double get s2 => curveS2[this] ?? 1.0;
}
