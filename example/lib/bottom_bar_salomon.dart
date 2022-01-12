import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Salomon extends StatefulWidget {
  static const String routeName = '/product';
  final List<TabItem> items;

  const Salomon({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _SalomonState createState() => _SalomonState();
}

class _SalomonState extends State<Salomon> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 87),
          Container(),
          BottomBarSalomon(
            items: widget.items,
            color: Colors.blue,
            backgroundColor: Colors.white,
            colorSelected: Colors.white,
            backgroundSelected: Colors.blue,
            indexSelected: visit,
            animated: false,
            onTap: (index) => setState(() {
              visit = index;
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarSalomon(
        items: widget.items,
        color: Colors.blue,
        backgroundColor: Colors.red.withOpacity(0.4),
        colorSelected: Colors.white,
        backgroundSelected: Colors.blue,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
