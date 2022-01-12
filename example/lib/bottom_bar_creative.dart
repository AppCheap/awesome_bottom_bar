import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Creative extends StatefulWidget {
  final List<TabItem> items;
  final HighlightStyle? highlightStyle;
  final bool? isFloating;

  const Creative({
    Key? key,
    required this.items,
    this.highlightStyle,
    this.isFloating,
  }) : super(key: key);

  @override
  _CreativeState createState() => _CreativeState();
}

class _CreativeState extends State<Creative> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarCreative(
        items: widget.items,
        backgroundColor: Colors.green.withOpacity(0.21),
        color:const Color(0XFF7AC0FF),
        colorSelected:const Color(0XFF0686F8),
        indexSelected: visit,
        highlightStyle: widget.highlightStyle,
        isFloating: widget.isFloating ?? false,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
