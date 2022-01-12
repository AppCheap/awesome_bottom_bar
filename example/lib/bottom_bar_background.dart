import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Background extends StatefulWidget {
  final List<TabItem> items;

  const Background({
    Key? key,
    required this.items,
  }):super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 47),
          Container(),
          BottomBarBackground(
            items: widget.items,
            backgroundColor: Colors.green,
            backgroundSelected: Colors.blue,
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
      bottomNavigationBar: BottomBarBackground(
        items: widget.items,
        backgroundColor: Colors.green,
        color: Colors.white,
        colorSelected: Colors.orange,
        indexSelected: visit,
        backgroundSelected: Colors.blue,
        paddingVertical: 25,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
