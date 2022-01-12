import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Fancy extends StatefulWidget {
  final List<TabItem> items;
  final StyleIconFooter? style;

  const Fancy({Key? key, required this.items, this.style}):super(key: key);

  @override
  _FancyState createState() => _FancyState();
}

class _FancyState extends State<Fancy> {
  int visit = 0;
  double height = 30;
  Color color = const Color(0XFF7AC0FF);
  Color colorSelected = const Color(0XFF0686F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height),
          BottomBarInspiredFancy(
            items: widget.items,
            backgroundColor: Colors.green.withOpacity(0.21),
            color: color,
            colorSelected: colorSelected,
            indexSelected: visit,
            styleIconFooter: widget.style ?? StyleIconFooter.divider,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: false,
          ),
          SizedBox(
            height: height,
          )
        ],
      ),
      bottomNavigationBar: BottomBarInspiredFancy(
        items: widget.items,
        backgroundColor: Colors.green.withOpacity(0.21),
        color: color,
        colorSelected: colorSelected,
        indexSelected: visit,
        styleIconFooter: widget.style ?? StyleIconFooter.divider,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
