import 'dart:ui' show lerpDouble;

import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:flutter/material.dart';

import '../count_style.dart';
import '../tab_item.dart';
import 'bottom_bar.dart';
import '../widgets/build_icon.dart';

enum StyleDivider { top, bottom, all }

class BottomBarDivider extends StatefulWidget {
  final List<TabItem> items;

  /// view
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final double? blur;

  /// item
  final int indexSelected;
  final Function(int index)? onTap;
  final EdgeInsets? paddingVertical;

  final Color color;
  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final CountStyle? countStyle;

  /// enable Divider
  final StyleDivider styleDivider;

  final Duration? duration;
  final Curve? curve;
  final bool animated;
  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;

  const BottomBarDivider(
      {Key? key,
      required this.items,
      required this.backgroundColor,
      this.boxShadow,
      this.blur,
      this.indexSelected = 0,
      this.onTap,
      this.paddingVertical,
      required this.color,
      required this.colorSelected,
      this.iconSize = 22,
      this.titleStyle,
      this.countStyle,
      this.styleDivider = StyleDivider.top,
      this.duration,
      this.curve,
      this.animated = true,
      this.top = 12,
      this.bottom = 12,
      this.pad = 4,
      this.enableShadow = true})
      : super(key: key);

  @override
  _BottomBarDividerState createState() => _BottomBarDividerState();
}

class _BottomBarDividerState extends State<BottomBarDivider> {
  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr) {
      return lerpDouble(-1.0, 1.0, index / (widget.items.length - 1))!;
    } else {
      return lerpDouble(1.0, -1.0, index / (widget.items.length - 1))!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? Stack(
              alignment: widget.styleDivider == StyleDivider.bottom ? Alignment.bottomCenter : Alignment.topCenter,
              children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(widget.items.length, (index) {
                        return Expanded(
                          child: InkWell(
                            onTap: () => widget.onTap?.call(index),
                            child: widget.items.length > index
                                ? SizedBox(
                                    child: buildItem(
                                      context,
                                      item: widget.items[index],
                                      color: widget.color,
                                      isSelected: index == widget.indexSelected,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    width: width,
                    child: AnimatedAlign(
                      alignment: Alignment(_getIndicatorPosition(widget.indexSelected), 0),
                      curve: widget.curve ?? Curves.ease,
                      duration: widget.animated
                          ? widget.duration ?? const Duration(milliseconds: 300)
                          : const Duration(milliseconds: 0),
                      child: Container(
                        color: widget.colorSelected,
                        width: width / widget.items.length,
                        height: 4,
                      ),
                    ),
                  ),
                ])
          : null,
    );
  }

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    bool isSelected = false,
    required Color color,
    CountStyle? countStyle,
  }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;

    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
    );
    isShadow = widget.enableShadow!;
    Color itemColor = isSelected ? widget.colorSelected : color;
    return Container(
      width: double.infinity,
      padding: padDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad),
            Text(
              item.title!,
              style: Theme.of(context).textTheme.overline?.merge(widget.titleStyle).copyWith(color: itemColor),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }
}
