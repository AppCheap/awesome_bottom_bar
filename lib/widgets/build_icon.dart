import 'package:flutter/material.dart';

import '../tab_item.dart';
import '../count_style.dart';

class BuildIcon extends StatelessWidget {
  final TabItem item;
  final double iconSize;
  final Color iconColor;
  final CountStyle? countStyle;

  const BuildIcon({
    Key? key,
    required this.item,
    required this.iconColor,
    this.iconSize = 22,
    this.countStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Check if the icon is a Widget
    if (item.icon is Widget) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(colors: [iconColor, iconColor])
                .createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: item.icon as Widget,
        ),
      );
    }

    Widget icon = Icon(
      item.icon,
      size: iconSize,
      color: iconColor,
    );
    if (item.count is Widget) {
      double sizeBadge = countStyle?.size ?? 18;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            item.icon,
            size: iconSize,
            color: iconColor,
          ),
          PositionedDirectional(
            start: iconSize - sizeBadge / 2,
            top: -sizeBadge / 2,
            child: item.count!,
          ),
        ],
      );
    }
    return icon;
  }
}
