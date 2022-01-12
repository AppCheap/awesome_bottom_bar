import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:flutter/material.dart';

import '../count_style.dart';
import '../tab_item.dart';
import 'bottom_bar.dart';
import '../widgets/build_icon.dart';

class BottomBarDefault extends StatefulWidget {
  final List<TabItem> items;

  /// view
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? blur;

  /// item
  final int indexSelected;
  final Function(int index)? onTap;

  final Color color;
  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final double? paddingVertical;
  final CountStyle? countStyle;
  final Duration? duration;
  final Curve? curve;
  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;
  final bool animated;
  const BottomBarDefault({
    Key? key,
    required this.items,
    required this.backgroundColor,
    this.boxShadow,
    this.blur,
    this.borderRadius,
    this.indexSelected = 0,
    this.onTap,
    required this.color,
    required this.colorSelected,
    this.iconSize = 22,
    this.titleStyle,
    this.paddingVertical,
    this.countStyle,
    this.animated = true,
    this.duration,
    this.curve,
    this.top = 12,
    this.bottom = 12,
    this.pad = 4,
    this.enableShadow = true,
  }) : super(key: key);

  @override
  _BottomBarDefaultState createState() => _BottomBarDefaultState();
}

class _BottomBarDefaultState extends State<BottomBarDefault> with TickerProviderStateMixin {
  late List<AnimationController> _animationControllerList;
  late List<Animation<double>> _animationList;

  int? _lastSelectedIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = widget.indexSelected;
    _animationControllerList = List<AnimationController>.empty(growable: true);
    _animationList = List<Animation<double>>.empty(growable: true);

    for (int i = 0; i < widget.items.length; ++i) {
      _animationControllerList
          .add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
      _animationList.add(Tween(begin: 1.0, end: 1.18)
          .chain(CurveTween(curve: widget.curve ?? Curves.ease))
          .animate(_animationControllerList[i]));
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _animationControllerList[_selectedIndex!].forward();
    });
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.items.length; ++i) {
      _animationControllerList[i].dispose();
    }
    super.dispose();
  }

  Widget buildItem(BuildContext context, {required TabItem item, required int index, bool isSelected = false}) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
    );
    isShadow = widget.enableShadow!;
    Color itemColor = isSelected ? widget.colorSelected : widget.color;
    if (widget.animated) {
      return AnimatedBuilder(
        animation: _animationList[index],
        builder: (context, child) {
          return Transform.scale(
            scale: _animationList[index].value,
            child: buildContentItem(item, itemColor, padDefault),
          );
        },
      );
    }
    return buildContentItem(item, itemColor, padDefault);
  }

  Widget buildContentItem(
    TabItem item,
    Color itemColor,
    EdgeInsets padDefault,
  ) {
    return Container(
      width: double.infinity,
      padding:
          widget.paddingVertical != null ? EdgeInsets.symmetric(vertical: widget.paddingVertical ?? 17.0) : padDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
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

  @override
  Widget build(BuildContext context) {
    if (widget.items.length != _animationControllerList.length) {
      _animationControllerList = List<AnimationController>.empty(growable: true);
      _animationList = List<Animation<double>>.empty(growable: true);

      for (int i = 0; i < widget.items.length; ++i) {
        _animationControllerList
            .add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
        _animationList.add(Tween(begin: 1.0, end: 1.18)
            .chain(CurveTween(curve: widget.curve ?? Curves.ease))
            .animate(_animationControllerList[i]));
      }
    }

    if (widget.indexSelected != _selectedIndex) {
      setState(() {
        _lastSelectedIndex = _selectedIndex;
        _selectedIndex = widget.indexSelected;
      });
      if (widget.animated) {
        _animationControllerList[_selectedIndex!].forward();
        _animationControllerList[_lastSelectedIndex!].reverse();
      }
    }
    isShadow = widget.enableShadow!;
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(widget.items.length, (index) {
                  return Expanded(
                    child: InkWell(
                      onTap: index != _selectedIndex!
                          ? () {
                              if (index != _selectedIndex) {
                                widget.onTap!.call(index);
                                if (widget.onTap == null) {
                                  setState(() {
                                    _lastSelectedIndex = _selectedIndex;
                                    _selectedIndex = index;
                                  });
                                  if (widget.animated) {
                                    _animationControllerList[_selectedIndex!].forward();
                                    _animationControllerList[_lastSelectedIndex!].reverse();
                                  }
                                }
                              }
                            }
                          : null,
                      child: buildItem(
                        context,
                        item: widget.items[index],
                        index: index,
                        isSelected: index == _selectedIndex!,
                      ),
                    ),
                  );
                }),
              ),
            )
          : null,
    );
  }
}
