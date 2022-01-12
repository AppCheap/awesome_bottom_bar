import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class OutSide extends StatefulWidget {
  static const String routeName = '/product';
  final List<TabItem> items;
  final ItemStyle? style;
  final ChipStyle? chipStyle;
  final double? top;

  const OutSide({
    Key? key,
    required this.items,
    this.chipStyle,
    this.style,
    this.top,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<OutSide> {
  int visit = 0;
  Color color = const Color(0XFF96B1FD);
  Color bground = const Color(0XFF1752FE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 87),
          Container(),
          BottomBarInspiredOutside(
            items: widget.items,
            backgroundColor: bground,
            color: color,
            colorSelected: Colors.white,
            indexSelected: visit,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: false,
            duration: const Duration(microseconds: 0),
            top: widget.top ?? -44,
            itemStyle: widget.style ?? ItemStyle.circle,
            chipStyle: widget.chipStyle ?? const ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarInspiredOutside(
        items: widget.items,
        backgroundColor: bground,
        color: color,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
        itemStyle: widget.style ?? ItemStyle.circle,
        chipStyle: widget.chipStyle ?? const ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge),
      ),
    );
  }
}
