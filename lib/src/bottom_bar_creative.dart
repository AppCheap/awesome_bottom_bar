import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:flutter/material.dart';

import '../widgets/build_icon.dart';
import '../widgets/hexagon/hexagon.dart';
import 'bottom_bar.dart';

class BottomBarCreative extends StatefulWidget {
  final List<TabItem> items;

  /// view
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? blur;
  final int? visitHighlight;

  /// item
  final int indexSelected;
  final Function(int index)? onTap;

  final Color color;
  final Color colorSelected;
  final Color? backgroundSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final double? paddingVertical;
  final CountStyle? countStyle;
  final HighlightStyle? highlightStyle;

  final bool isFloating;

  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;

  const BottomBarCreative({
    Key? key,
    required this.items,
    required this.backgroundColor,
    this.boxShadow,
    this.blur,
    this.visitHighlight,
    this.borderRadius,
    this.indexSelected = 0,
    this.onTap,
    required this.color,
    required this.colorSelected,
    this.iconSize = 22,
    this.titleStyle,
    this.backgroundSelected,
    this.paddingVertical,
    this.countStyle,
    this.isFloating = false,
    this.highlightStyle,
    this.top = 12,
    this.bottom = 12,
    this.pad = 4,
    this.enableShadow = true,
  }) : super(
          key: key,
        );

  @override
  _BottomBarCreativeState createState() => _BottomBarCreativeState();
}

class _BottomBarCreativeState extends State<BottomBarCreative> {
  @override
  Widget build(BuildContext context) {
    int defaultVisit = widget.items.length / 2 == 0 ? 0 : (widget.items.length / 2).ceil() - 1;
    int visit = widget.visitHighlight ?? defaultVisit;

    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
    );

    EdgeInsetsGeometry pad = widget.paddingVertical != null ? const EdgeInsets.symmetric(vertical: 12.0) : padDefault;

    double sizeHighlight = widget.highlightStyle?.sizeLarge == true ? 56 : 48;

    isShadow = widget.enableShadow!;

    EdgeInsetsGeometry padTop = widget.isFloating ? EdgeInsets.only(top: sizeHighlight/2) : EdgeInsets.zero;

    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: padTop,
            child: BuildLayout(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: widget.borderRadius,
                boxShadow: widget.boxShadow ?? shadow,
              ),
            ),
          ),
        ),
        if (widget.items.isNotEmpty)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(widget.items.length, (index) {
                TabItem item = widget.items[index];
                String value = widget.items[index].key ?? '';
                if (visit == index) {
                  Widget highlightWidget = GestureDetector(
                    key: Key(value),
                    onTap: index != widget.indexSelected ? () => widget.onTap?.call(visit) : null,
                    child: buildHighLight(context, item: item, color: widget.colorSelected, size: sizeHighlight),
                  );
                  return !widget.isFloating
                      ? Container(
                          padding: pad,
                          alignment: Alignment.center,
                          child: highlightWidget
                        )
                      : Column(
                        children: [
                          highlightWidget
                        ],
                      );
                }
                return Expanded(
                  child: Padding(
                    padding: padTop,
                    child: InkWell(
                      key: ValueKey(value),
                      onTap: index != widget.indexSelected ? () => widget.onTap?.call(index) : null,
                      child: widget.items.length > index
                          ? buildItem(
                        context,
                        item: item,
                        color: widget.color,
                        isSelected: index == widget.indexSelected,
                      )
                          : null,
                    ),
                  ),
                );
              }),
            ),
          )
        else Container(),
      ],
    );
  }

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    bool isSelected = false,
    required Color color,
    double sizeIcon = 22,
    TextStyle? styleTitle,
    double? paddingVer,
    CountStyle? countStyle,
  }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;

    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
    );
    Color itemColor = isSelected ? widget.colorSelected : color;

    return Container(
      padding: paddingVer != null ? EdgeInsets.symmetric(vertical: paddingVer) : padDefault,
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
              style: Theme.of(context).textTheme.labelSmall?.merge(widget.titleStyle).copyWith(color: itemColor),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }

  Widget buildHighLight(
    BuildContext context, {
    required TabItem item,
    required Color color,
    double size = 48,
    CountStyle? countStyle,
  }) {
    Color background = widget.highlightStyle?.background ?? color;
    Color colorIcon = widget.highlightStyle?.color ?? Colors.white;
    if (widget.highlightStyle?.isHexagon == true) {
      return HexagonWidget(
        width: size,
        height: size,
        color: background,
        elevation: widget.highlightStyle?.elevation ?? 0,
        child: BuildIcon(
          item: item,
          iconColor: colorIcon,
          iconSize: 22,
          countStyle: countStyle,
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: widget.highlightStyle?.elevation ?? 0,
      color: background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size / 2)),
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: BuildIcon(
          item: item,
          iconColor: colorIcon,
          iconSize: 22,
          countStyle: countStyle,
        ),
      ),
    );
  }
}
