import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class DividerDemo extends StatefulWidget {
  static const String routeName = '/product';
  final List<TabItem> items;
  final StyleDivider? styleDivider;

  const DividerDemo({Key? key, required this.items, this.styleDivider}) : super(key: key);

  @override
  _DividerDemoState createState() => _DividerDemoState();
}

class _DividerDemoState extends State<DividerDemo> {
  int visit = 0;
  CountStyle countStyle = const CountStyle(
    background: Colors.white,
    color: Colors.purple,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 87),
          BottomBarDivider(
            items: widget.items,
            backgroundColor: Colors.amber,
            color: Colors.grey,
            colorSelected: Colors.blue,
            indexSelected: visit,
            onTap: (index) => setState(() {
              visit = index;
            }),
            duration: const Duration(microseconds: 0),
            styleDivider: widget.styleDivider ?? StyleDivider.top,
            countStyle: countStyle,
          ),
        ],
      ),
      bottomNavigationBar: BottomBarDivider(
        items: widget.items,
        backgroundColor: Colors.amber,
        color: Colors.grey,
        colorSelected: Colors.blue,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
        styleDivider: widget.styleDivider ?? StyleDivider.bottom,
        countStyle: countStyle,
      ),
    );
  }
}
