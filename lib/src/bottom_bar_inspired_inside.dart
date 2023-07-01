import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import '../chip_style.dart';
import '../count_style.dart';
import '../tab_item.dart';

class BottomBarInspiredInside extends StatefulWidget {
  final List<TabItem> items;
  final double? height;
  final Color backgroundColor;
  final double? elevation;
  final bool fixed;
  final int indexSelected;
  final Function(int index)? onTap;
  final Color color;
  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final CountStyle? countStyle;
  final ChipStyle? chipStyle;
  final ItemStyle? itemStyle;
  final bool animated;
  final bool isAnimated;
  final Duration? duration;
  final Curve? curve;
  final double? sizeInside;
  final double? padTop;
  final double? padbottom;
  final double? pad;
  final double? radius;
  final int? fixedIndex;
  const BottomBarInspiredInside({
    Key? key,
    required this.items,
    required this.backgroundColor,
    required this.color,
    required this.colorSelected,
    this.height = 40,
    this.elevation,
    this.fixed = false,
    this.indexSelected = 0,
    this.onTap,
    this.iconSize = 22,
    this.titleStyle,
    this.countStyle,
    this.chipStyle,
    this.itemStyle,
    this.animated = true,
    this.isAnimated = true,
    this.duration,
    this.curve,
    this.sizeInside = 48,
    this.padTop = 12,
    this.padbottom = 12,
    this.pad = 4,
    this.radius = 0,
    this.fixedIndex = 0,
  }) : super(key: key);

  @override
  _BottomBarInspiredInsideState createState() => _BottomBarInspiredInsideState();
}

class _BottomBarInspiredInsideState extends State<BottomBarInspiredInside> {
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Inspired(
      height: widget.height!,
      background: widget.backgroundColor,
      fixed: widget.fixed,
      elevation: widget.elevation,
      animated: widget.animated,
      isAnimated: widget.isAnimated,
      pad: widget.pad,
      padTop: widget.padTop,
      padbottom: widget.padbottom,
      fixedIndex: widget.fixedIndex,
      radius: widget.radius,
      initialActive: widget.indexSelected,
      items: widget.items,
      onTap: widget.onTap,
      chipStyle: widget.chipStyle,
      itemStyle: widget.itemStyle,
      color: widget.color,
      colorSelected: widget.colorSelected,
      iconSize: widget.iconSize,
      countStyle: widget.countStyle,
      titleStyle: widget.titleStyle,
      sizeInside: widget.sizeInside,
      duration: widget.duration,
      curve: widget.curve ?? Curves.easeInOutCubic,
      animateStyle: 'flip',
    );
  }
}
