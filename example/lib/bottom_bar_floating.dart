import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Floating extends StatefulWidget {
  final List<TabItem> items;

  const Floating({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _FloatingState createState() => _FloatingState();
}

class _FloatingState extends State<Floating> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding:const EdgeInsets.only(bottom: 30, left: 32, right: 32),
        child: BottomBarFloating(
          items: widget.items,
          backgroundColor: Colors.green,
          color: Colors.white,
          colorSelected: Colors.orange,
          indexSelected: visit,
          paddingVertical: 17,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
      ),
    );
  }
}
