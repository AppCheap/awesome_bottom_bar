import 'dart:ui';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

abstract class BottomBar extends StatefulWidget {
  final List<TabItem> itemData;

  /// view
  final Color background;
  final List<BoxShadow>? shadow;
  final double? doubleBlur;

  /// item
  final int indexActive;
  final Function(int index)? onChange;

  /// style
  final Color colorItem;
  final Color activeColor;
  final double sizeIcon;
  final TextStyle? styleTitle;
  final double? paddingVer;

  final CountStyle? styleCount;
  // final Color? countStyle;
  // final Color? backgroundCount;

  const BottomBar({
    Key? key,
    required this.itemData,
    required this.background,
    this.shadow,
    this.indexActive = 0,
    this.onChange,
    required this.colorItem,
    required this.activeColor,
    this.sizeIcon = 22,
    this.styleTitle,
    this.paddingVer,
    this.doubleBlur,
    this.styleCount,
  })  : assert(indexActive == 0 || indexActive < itemData.length),
        super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    bool isSelected,
    required Color color,
    required Color activeColor,
    double sizeIcon,
    TextStyle? styleTitle,
    double? paddingVer,
    CountStyle? countStyle,
  });

  @protected
  Widget buildLayout(
    BuildContext context, {
    required List<TabItem> itemData,
    required Color background,
    List<BoxShadow>? shadowLayout,
    double? blur,
    int indexActive,
    Function(int index)? onChange,
    required Widget Function(
      TabItem item,
      bool isSelected,
    )
        buildView,
  });
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return widget.buildLayout(
      context,
      itemData: widget.itemData,
      background: widget.background,
      shadowLayout: widget.shadow,
      blur: widget.doubleBlur,
      indexActive: widget.indexActive,
      onChange: widget.onChange,
      buildView: (TabItem item, bool isSelected) => widget.buildItem(
        context,
        item: item,
        isSelected: isSelected,
        color: widget.colorItem,
        activeColor: widget.activeColor,
        sizeIcon: widget.sizeIcon,
        styleTitle: widget.styleTitle,
        paddingVer: widget.paddingVer,
        countStyle: widget.styleCount,
      ),
    );
  }
}

class BuildLayout extends StatelessWidget {
  final Widget? child;
  final BoxDecoration? decoration;
  final double? blur;
  final Clip? clipBehavior;

  const BuildLayout({
    Key? key,
    this.child,
    this.decoration,
    this.blur,
    this.clipBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blur != null) {
      return Container(
        decoration: decoration,
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur ?? 4, sigmaY: blur ?? 4),
            child: Container(
              decoration: decoration?.copyWith(color: Colors.transparent),
              child: child,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: decoration,
      clipBehavior: clipBehavior ?? Clip.antiAliasWithSaveLayer,
      child: child,
    );
  }
}
