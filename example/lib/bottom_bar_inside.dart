import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Inside extends StatefulWidget {
  final List<TabItem> items;
  final ItemStyle? style;
  final ChipStyle? chipStyle;

  const Inside({
    Key? key,
    required this.items,
    this.style,
    this.chipStyle,
  }) : super(key: key);

  @override
  _InsideState createState() => _InsideState();
}

class _InsideState extends State<Inside> {
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
          BottomBarInspiredInside(
            items: widget.items,
            backgroundColor: bground,
            color: color,
            colorSelected: Colors.white,
            indexSelected: visit,
            animated: false,
            onTap: (index) => setState(() {
              visit = index;
            }),
            itemStyle: widget.style ?? ItemStyle.circle,
            chipStyle: widget.chipStyle ??const ChipStyle(isHexagon: false),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarInspiredInside(
        items: widget.items,
        backgroundColor: bground,
        color: color,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
        itemStyle: widget.style ?? ItemStyle.circle,
        chipStyle: widget.chipStyle ??const ChipStyle(isHexagon: false),
      ),
    );
  }
}
