import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Default extends StatefulWidget {
  final List<TabItem> items;

  const Default({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _DefaultState createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 47),
          Container(),
          BottomBarDefault(
            items: widget.items,
            backgroundColor: Colors.green,
            color: Colors.white,
            colorSelected: Colors.orange,
            indexSelected: visit,
            animated: false,
            onTap: (int index) => setState(() {
              visit = index;
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarDefault(
        items: widget.items,
        backgroundColor: Colors.green,
        color: Colors.white,
        colorSelected: Colors.orange,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
