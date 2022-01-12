import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:awesome_bottom_bar/src/bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/build_icon.dart';
import 'package:flutter/material.dart';

class BottomBarSalomon extends StatefulWidget {
  final List<TabItem> items;
  final Function(int index)? onTap;
  final List<BoxShadow>? boxShadow;
  final Curve curve;

  final Duration duration;

  final BorderRadius? radiusSalomon;

  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final int indexSelected;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Color backgroundSelected;
  final double? blur;
  final CountStyle? countStyle;
  final double? heightItem;
  final Color color;
  final bool animated;
  final double? top;
  final double? bottom;
  final bool? enableShadow;

  const BottomBarSalomon({
    Key? key,
    required this.items,
    required this.colorSelected,
    required this.color,
    required this.indexSelected,
    required this.backgroundColor,
    required this.backgroundSelected,
    this.blur,
    this.countStyle,
    this.heightItem = 38,
    this.boxShadow,
    this.onTap,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.radiusSalomon,
    this.iconSize = 22,
    this.titleStyle,
    this.borderRadius,
    this.animated = true,
    this.bottom = 12,
    this.top = 12,
    this.enableShadow = true,
  }) : super(
          key: key,
        );
  @override
  _BottomBarSalomonState createState() => _BottomBarSalomonState();
}

class _BottomBarSalomonState extends State<BottomBarSalomon> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.items.length,
                  (index) {
                    return GestureDetector(
                      onTap: index != widget.indexSelected ? () => widget.onTap?.call(index) : null,
                      child: widget.items.length > index
                          ? buildItem(
                              context,
                              item: widget.items[index],
                              color: widget.color,
                              isSelected: index == widget.indexSelected,
                            )
                          : null,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    required Color color,
    bool isSelected = false,
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
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
              tween: Tween(
                end: isSelected ? 1.0 : 0.0,
              ),
              duration: widget.duration,
              curve: widget.curve,
              builder: (context, t, _) {
                return buildContentItem(
                  item,
                  itemColor,
                  countStyle ?? const CountStyle(size: 12),
                  isSelected,
                  t,
                );
              },
            )
          : buildContentItem(
              item,
              itemColor,
              countStyle ?? const CountStyle(size: 12),
              isSelected,
              isSelected ? 1 : 0,
            ),
    );
  }

  Widget buildContentItem(
    TabItem item,
    Color itemColor,
    CountStyle countStyle,
    bool isSelected,
    double widthFactor,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 12),
      decoration: BoxDecoration(
        color: isSelected ? widget.backgroundSelected : Colors.transparent,
        borderRadius: widget.radiusSalomon ?? BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: widget.heightItem,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.title is String && item.title == '') ...[
              Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, left: 20),
                  child: BuildIcon(
                    item: item,
                    iconColor: itemColor,
                    iconSize: widget.iconSize,
                    countStyle: countStyle,
                  ),
                ),
              ),
            ],
            if (item.title is String && item.title != '') ...[
              BuildIcon(
                item: item,
                iconColor: itemColor,
                iconSize: widget.iconSize,
                countStyle: countStyle,
              ),
            ],
            if (item.title is String && item.title != '') ...[
              ClipRect(
                child: Align(
                  widthFactor: widthFactor,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Text(
                      item.title!,
                      style: Theme.of(context).textTheme.overline?.merge(widget.titleStyle).copyWith(color: itemColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
