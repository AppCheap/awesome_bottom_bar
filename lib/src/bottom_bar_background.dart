import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:flutter/material.dart';

import '../count_style.dart';
import '../tab_item.dart';
import 'bottom_bar.dart';
import '../widgets/build_icon.dart';

class BottomBarBackground extends StatefulWidget {
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
  final Color backgroundSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final double? paddingVertical;
  final CountStyle? countStyle;
  final bool animated;
  final Duration? duration;
  final Curve? curve;
  final double? top;
  final double? bottom;
  final double? pad;
  const BottomBarBackground({
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
    required this.backgroundSelected,
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
  }) : super(key: key);

  @override
  _BottomBarBackgroundState createState() => _BottomBarBackgroundState();
}

class _BottomBarBackgroundState extends State<BottomBarBackground> with TickerProviderStateMixin {
  late int _selectedIndex;
  late int _lastSelectedIndex;

  late List<AnimationController> _animationControllerList;
  late List<Animation<Color?>> _animationList;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexSelected;
    _lastSelectedIndex = 0;
    _animationControllerList = List<AnimationController>.empty(growable: true);
    _animationList = List<Animation<Color?>>.empty(growable: true);

    for (int i = 0; i < widget.items.length; ++i) {
      _animationControllerList
          .add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
      _animationList.add(ColorTween(begin: widget.color, end: widget.colorSelected)
          .chain(CurveTween(curve: widget.curve ?? Curves.ease))
          .animate(_animationControllerList[i]));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationControllerList[_selectedIndex].forward();
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
    if (widget.animated) {
      return AnimatedBuilder(
        animation: _animationList[index],
        builder: (context, child) {
          return buildContentItem(item, _animationList[index].value ?? Colors.black);
        },
      );
    }
    Color itemColor = isSelected ? widget.colorSelected : widget.color;
    return buildContentItem(item, itemColor);
  }

  Widget buildContentItem(TabItem item, Color color) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! >= 12 ? widget.bottom! + bottom : bottom,
    );
    return Container(
      width: double.infinity,
      padding: padDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BuildIcon(
            item: item,
            iconColor: color,
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad),
            Text(
              item.title!,
              style: Theme.of(context).textTheme.labelSmall?.merge(widget.titleStyle).copyWith(color: color),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant BottomBarBackground oldWidget) {
    if (widget.indexSelected != oldWidget.indexSelected) {
      int lastValue = oldWidget.indexSelected;
      int selectedValue = widget.indexSelected;
      setState(() {
        _lastSelectedIndex = lastValue;
        _selectedIndex = selectedValue;
      });
      if (widget.animated) {
        _animationControllerList[selectedValue].forward();
        _animationControllerList[lastValue].reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    if (widget.items.length != _animationControllerList.length) {
      _animationControllerList = List<AnimationController>.empty(growable: true);
      _animationList = List<Animation<Color?>>.empty(growable: true);

      for (int i = 0; i < widget.items.length; ++i) {
        _animationControllerList
            .add(AnimationController(duration: widget.duration ?? const Duration(milliseconds: 400), vsync: this));
        _animationList.add(ColorTween(begin: widget.color, end: widget.colorSelected)
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
        _animationControllerList[_selectedIndex].forward();
        _animationControllerList[_lastSelectedIndex].reverse();
      }
    }

    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? LayoutBuilder(builder: (_, BoxConstraints constraints) {
              double maxWidth = constraints.maxWidth;
              double width = maxWidth != double.infinity ? maxWidth : widthScreen;

              double widthItem = width / widget.items.length;

              return Stack(
                children: [
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    bottom: 0,
                    child: widget.animated
                        ? AnimatedContainer(
                            width: (_selectedIndex + 1) * widthItem,
                            height: double.infinity,
                            alignment: AlignmentDirectional.centerEnd,
                            duration: widget.duration ?? const Duration(milliseconds: 300),
                            curve: widget.curve ?? Curves.easeIn,
                            child: Container(
                              width: widthItem,
                              height: double.infinity,
                              color: widget.backgroundSelected,
                            ),
                          )
                        : Container(
                            width: widthItem,
                            height: double.infinity,
                            color: widget.backgroundSelected,
                            margin: EdgeInsetsDirectional.only(start: _selectedIndex * widthItem),
                          ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(widget.items.length, (index) {
                        String value = widget.items[index].key ?? '';
                        return Expanded(
                          child: InkWell(
                            key: Key(value),
                            onTap: index != _selectedIndex
                                ? () {
                                    if (index != _selectedIndex) {
                                      widget.onTap!.call(index);
                                      if (widget.onTap == null) {
                                        setState(() {
                                          _lastSelectedIndex = _selectedIndex;
                                          _selectedIndex = index;
                                        });
                                        if (widget.animated) {
                                          _animationControllerList[_selectedIndex].forward();
                                          _animationControllerList[_lastSelectedIndex].reverse();
                                        }
                                      }
                                    }
                                  }
                                : null,
                            child: buildItem(
                              context,
                              item: widget.items[index],
                              index: index,
                              isSelected: index == _selectedIndex,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            })
          : null,
    );
  }
}
