import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:flutter/material.dart';

import '../tab_item.dart';
import '../count_style.dart';
import '../widgets/build_icon.dart';
import 'bottom_bar.dart';

enum StyleIconFooter { divider, dot }

class BottomBarInspiredFancy extends StatefulWidget {
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
  final StyleIconFooter styleIconFooter;
  final bool animated;
  final Duration? duration;
  final Curve? curve;
  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;

  const BottomBarInspiredFancy({
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
    this.styleIconFooter = StyleIconFooter.divider,
    this.animated = true,
    this.duration,
    this.curve,
    this.bottom = 24,
    this.top = 24,
    this.pad = 4,
    this.enableShadow = true,
  }) : super(key: key);

  @override
  _BottomBarInspiredFancyState createState() => _BottomBarInspiredFancyState();
}

class _BottomBarInspiredFancyState extends State<BottomBarInspiredFancy> with TickerProviderStateMixin {
  late List<AnimationController> _animationControllerList;
  late List<Animation<Color?>> _animationList;

  late int _selectedIndex;
  late int _lastSelectedIndex;

  @override
  void initState() {
    super.initState();
    _lastSelectedIndex = 0;
    _selectedIndex = widget.indexSelected;
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

  Widget buildItem(
    BuildContext context, {
    required TabItem item,
    required int index,
    bool isSelected = false,
    double padTop = 24,
    double padBottom = 24,
  }) {
    EdgeInsets padding = EdgeInsets.only(top: widget.top ?? padTop, bottom: padBottom);

    double widthFancy = widget.styleIconFooter == StyleIconFooter.dot ? 4 : widget.iconSize;
    bool active = index == _selectedIndex;
    BoxDecoration decorationFancy = widget.styleIconFooter == StyleIconFooter.dot
        ? BoxDecoration(color: active ? widget.colorSelected : Colors.transparent, shape: BoxShape.circle)
        : BoxDecoration(color: active ? widget.colorSelected : Colors.transparent);
    Widget fancy = widget.animated
        ? AnimatedContainer(
            height: 4,
            width: widthFancy,
            decoration: decorationFancy,
            duration: widget.duration ?? const Duration(milliseconds: 300),
            curve: widget.curve ?? Curves.easeIn,
            margin: active ? EdgeInsets.zero : EdgeInsets.only(top: padBottom - 12),
          )
        : Container(
            height: 4,
            width: widthFancy,
            decoration: decorationFancy,
          );
    return Stack(
      children: [
        if (widget.animated)
          AnimatedBuilder(
            animation: _animationList[index],
            builder: (context, child) {
              return buildItemContent(item, active ? widget.colorSelected : widget.color, padding);
            },
          )
        else
          buildItemContent(item, active ? widget.colorSelected : widget.color, padding),
        Positioned(
          left: 0,
          right: 0,
          bottom: padBottom - 8,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(),
              Positioned(
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: fancy,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItemContent(TabItem item, Color color, EdgeInsetsGeometry padding) {
    return Container(
      width: double.infinity,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BuildIcon(
            item: item,
            iconColor: color,
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad ?? 4),
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
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;

    double padBottomDefault = bottom > 0 ? bottom : 24;

    double padTop = widget.paddingVertical ?? 24;
    double padBottom = widget.bottom ?? widget.paddingVertical ?? padBottomDefault;

    if (padBottom < 12) {
      padBottom = padBottom + 12;
    }

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

    isShadow = widget.enableShadow!;

    return BuildLayout(
      decoration: BoxDecoration(
          color: widget.backgroundColor, borderRadius: widget.borderRadius, boxShadow: widget.boxShadow ?? shadow),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? IntrinsicHeight(
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
                      child: widget.items.length > index
                          ? buildItem(
                              context,
                              item: widget.items[index],
                              index: index,
                              isSelected: index == _selectedIndex,
                              padTop: padTop,
                              padBottom: padBottom,
                            )
                          : null,
                    ),
                  );
                }),
              ),
            )
          : null,
    );
  }
}
