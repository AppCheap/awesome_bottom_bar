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


import '../../chip_style.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'stack.dart' as extend;
import 'painter.dart';

/// Default size of the curve line.
const double converSize = 80;

enum ItemStyle { hexagon, circle }

class Inspired extends StatefulWidget {
  final int count;
  final bool fixed;
  final double height;
  final Color background;
  final int? initialActive;
  final Curve curve;
  final double? cornerRadius;
  final void Function(int index)? onTap;
  final Widget Function(BuildContext context, int index, bool active) itemBuilder;
  final ChipStyle? chipStyle;
  final double? elevation;
  final IconData Function(int index) iconChip;
  final double? top;
  final double? curveSize;
  final double? containerSize;
  final ItemStyle? itemStyle;
  final bool? animated;
  final bool? isAnimated;
  final Color? shadowColor;
  final double? padTop;
  final double? padbottom;
  final double? pad;
  final double? radius;
  final int? fixedIndex;
  const Inspired({
    Key? key,
    required this.background,
    required this.itemBuilder,
    required this.iconChip,
    this.count = 5,
    this.fixed = false,
    this.height = 40,
    this.initialActive,
    this.curve = Curves.easeInOut,
    this.cornerRadius,
    this.onTap,
    this.chipStyle,
    this.elevation,
    this.top = -18,
    this.curveSize,
    this.containerSize,
    this.itemStyle = ItemStyle.circle,
    this.animated = true,
    this.isAnimated = true,
    this.shadowColor,
    this.padTop = 12,
    this.padbottom = 12,
    this.pad = 4,
    this.radius = 0,
    this.fixedIndex = 0,
  }) : super(key: key);

  @override
  _InspiredState createState() => _InspiredState();
}

class _InspiredState extends State<Inspired> with TickerProviderStateMixin {
  int? _currentIndex;
  Animation<double>? _animation;
  AnimationController? _animationController;
  TabController? _controller;

  static const _transitionDuration = 100;

  @override
  void initState() {
    if (widget.cornerRadius != null && widget.cornerRadius! > 0 && !widget.fixed) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('ConvexAppBar is configured with cornerRadius'),
        ErrorDescription('Currently the corner only work for fixed style, if you are using '
            'other styles, the convex shape can be broken on the first and last tab item '),
        ErrorHint('You should use TabStyle.fixed or TabStyle.fixedCircle to make the'
            ' background display with topLeft/topRight corner'),
      ]);
    }
    _resetState();
    super.initState();
  }

  /// change active tab index; can be used with [PageView].
  Future<void> animateTo(int index, {int? from}) async {
    _updateAnimation(
      from: from ?? _currentIndex,
      to: index,
      duration:
          widget.animated == true ? const Duration(milliseconds: _transitionDuration) : const Duration(microseconds: 0),
    );
    // ignore: unawaited_futures
    _animationController?.forward();
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Animation<double> _updateAnimation({
    int? from,
    int? to,
    Duration duration = const Duration(milliseconds: _transitionDuration),
  }) {
    if (from != null && (from == to) && _animation != null) {
      return _animation!;
    }
    from ??= widget.fixed ? widget.fixedIndex : _controller?.index ?? widget.initialActive ?? 0;
    to ??= from;
    final lower = (2 * from! + 1) / (2 * widget.count);
    final upper = (2 * to! + 1) / (2 * widget.count);
    _animationController?.dispose();
    final controller = AnimationController(duration: duration, vsync: this);
    final curve = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );
    _animationController = controller;
    return _animation = Tween(begin: lower, end: upper).animate(curve);
  }

  @override
  void dispose() {
    _controller = null;

    _animationController?.dispose();
    super.dispose();
  }

  void _resetState() {
    var index = _controller?.index ?? widget.initialActive;
    // when both initialActiveIndex and controller are not configured
    _currentIndex = index ?? 0;

    if (!widget.fixed && _controller != null) {
      // when controller is not defined, the default index can rollback to 0
      // https://github.com/hacktons/convex_bottom_bar/issues/67
      _updateAnimation();
    }
  }

  void _onTabClick(int i) {
    animateTo(i);
    _controller?.animateTo(i);
    widget.onTap?.call(i);
  }

  @override
  void didUpdateWidget(Inspired oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count || widget.animated == oldWidget.animated) {
      _resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom, 0.0);

    int convexIndex = widget.fixed ? (widget.fixedIndex ?? (widget.count ~/ 2)) : _currentIndex ?? 0;

    bool active = widget.fixed ? convexIndex == _currentIndex : true;

    double height = widget.height + additionalBottomPadding + widget.pad! + widget.padTop! + widget.padbottom!;
    double width = MediaQuery.of(context).size.width;

    Animation<double> percent = widget.fixed
        ? _updateAnimation()
        : widget.isAnimated == true
            ? _updateAnimation()
            : _updateAnimation();
    double factor = 1 / widget.count;
    TextDirection textDirection = Directionality.of(context);
    double dx = convexIndex / (widget.count - 1);
    if (textDirection == TextDirection.rtl) {
      dx = 1 - dx;
    }

    bool isHexagon = widget.chipStyle?.isHexagon ?? false;

    bool drawHexagon = widget.chipStyle?.drawHexagon ?? false;

    bool convexBridge = widget.chipStyle?.convexBridge ?? false;

    NotchSmoothness notchSmoothness = widget.chipStyle?.notchSmoothness ?? NotchSmoothness.defaultEdge;

    var offset = FractionalOffset(widget.count > 1 ? dx : 0.0, 0);
    return extend.Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SizedBox(
          height: height,
          width: width,
          child: CustomPaint(
            painter: ConvexPainter(
              top: drawHexagon || !convexBridge ? -38 : -22,
              width: widget.curveSize ?? converSize,
              height: 78,
              color: widget.background,
              shadowColor: widget.shadowColor ?? const Color.fromRGBO(0, 0, 0, 0.06),
              sigma: widget.elevation ?? 2,
              leftPercent: percent,
              textDirection: textDirection,
              isHexagon: isHexagon,
              drawHexagon: drawHexagon,
              notchSmoothness: notchSmoothness,
              convexBridge: convexBridge,
              leftCornerRadius: widget.fixed && widget.fixedIndex == 0
                  ? 0
                  : (widget.initialActive == 0 && !widget.fixed ? 0 : widget.radius!),
              rightCornerRadius: widget.fixed && widget.fixedIndex == widget.count - 1
                  ? 0
                  : (widget.initialActive == widget.count - 1 && !widget.fixed ? 0 : widget.radius!),
            ),
          ),
        ),
        _barContent(height, additionalBottomPadding, convexIndex),
        Positioned.fill(
          top: (widget.top! - widget.pad! - widget.padTop! - widget.padbottom!),
          bottom: additionalBottomPadding,
          child: FractionallySizedBox(
            widthFactor: factor,
            alignment: offset,
            child: GestureDetector(
              onTap: () => _onTabClick(convexIndex),
              child: widget.itemBuilder(context, convexIndex, active),
            ),
          ),
        ),
      ],
    );
  }

  Widget _barContent(double height, double paddingBottom, int curveTabIndex) {
    var children = <Widget>[];
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        children.add(Expanded(child: Container()));
        continue;
      }
      var active = _currentIndex == i;
      children.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTabClick(i),
          child: widget.itemBuilder(context, i, active),
        ),
      ));
    }
    return Container(
      height: height,
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

enum NotchSmoothness {
  sharpEdge,
  defaultEdge,
  softEdge,
  smoothEdge,
  verySmoothEdge,
}
