import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:example/bottom_bar_creative.dart';
import 'package:example/bottom_bar_default.dart';
import 'package:example/bottom_bar_fancy.dart';
import 'package:example/bottom_bar_salomon.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import 'bottom_bar_background.dart';
import 'bottom_bar_divider.dart';
import 'bottom_bar_floating.dart';
import 'bottom_bar_inside.dart';
import 'bottom_bar_outside.dart';
import 'debug/debug.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;
  double height = 30;
  Color colorSelect =const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const  Color(0XFF1752FE);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        padding:const EdgeInsets.only(left: 16),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          Text('Inside', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_inside_cricle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Inside(
                    items: items,
                    chipStyle: ChipStyle(convexBridge: true),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_inside_hexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Inside(
                    items: items,
                    style: ItemStyle.hexagon,
                    chipStyle: ChipStyle(
                      isHexagon: true,
                      convexBridge: true,
                    ),
                  ),
                ),
              );
            },
          ),
          Text('Outside', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_outside_sharpEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_default'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    style: ItemStyle.circle,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_verySmoothEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_smoothEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_softEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.softEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_drawHexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutSide(
                    items: items,
                    top: -40,
                    style: ItemStyle.hexagon,
                    chipStyle: ChipStyle(drawHexagon: true),
                  ),
                ),
              );
            },
          ),
          Text('Salomon', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_salomon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Salomon(items: items),
                ),
              );
            },
          ),
          Text('Divider', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_divider_top'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DividerDemo(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_divider_bottom'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DividerDemo(
                    items: items,
                    styleDivider: StyleDivider.bottom,
                  ),
                ),
              );
            },
          ),
          Text('Fancy', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_fancy_divider'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Fancy(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_fancy_dot'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Fancy(
                    items: items,
                    style: StyleIconFooter.dot,
                  ),
                ),
              );
            },
          ),
          Text('Default', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_default'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Default(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_background'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Background(items: items),
                ),
              );
            },
          ),
          Text('Floating', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_floating'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Floating(items: items),
                ),
              );
            },
          ),
          Text('Creative', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_creative_circle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Creative(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_creative_hexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Creative(
                    items: items,
                    highlightStyle: HighlightStyle(
                      isHexagon: true,
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_creative_cirlce_elevation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Creative(
                    items: items,
                    isFloating: true,
                    highlightStyle: HighlightStyle(
                      sizeLarge: true,
                      background: Colors.red,
                      elevation: 3,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ) // Populate the Drawer in the next step.
          ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: height),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -25,
              animated: true,
              itemStyle: ItemStyle.hexagon,
              chipStyle:const ChipStyle(drawHexagon: true),
            ),
            SizedBox(height: height),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
            ),
            SizedBox(height: height),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
            ),
            SizedBox(height: height),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
            ),
            SizedBox(height: height),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
            ),
            SizedBox(height: height),
            BottomBarInspiredInside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              chipStyle:const ChipStyle(convexBridge: true),
              itemStyle: ItemStyle.circle,
              animated: false,
            ),
            SizedBox(height: height),
            BottomBarInspiredInside(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              animated: false,
              chipStyle:const ChipStyle(isHexagon: true, convexBridge: true),
              itemStyle: ItemStyle.hexagon,
            ),
            BottomBarFloating(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              highlightStyle:const HighlightStyle(
                isHexagon: true,
              ),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              isFloating: true,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              isFloating: true,
              highlightStyle:const HighlightStyle(sizeLarge: true, background: Colors.red, elevation: 3),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              isFloating: true,
              highlightStyle:const HighlightStyle(sizeLarge: true, isHexagon: true, elevation: 2),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarInspiredFancy(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarInspiredFancy(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color,
              colorSelected: colorSelect,
              indexSelected: visit,
              styleIconFooter: StyleIconFooter.dot,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              onTap: (int index) => avoidPrint('$index'),
              blur: 50,
              countStyle:const CountStyle(
                background: Colors.brown,
              ),
            ),
            SizedBox(height: height),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              iconSize: 40,
              indexSelected: visit,
              titleStyle:const TextStyle(fontSize: 18, color: Colors.black),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              indexSelected: visit,
              paddingVertical: 25,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: height),
            BottomBarDivider(
              items: items,
              backgroundColor: Colors.amber,
              color: Colors.grey,
              colorSelected: Colors.blue,
              indexSelected: visit,
              onTap: (index) => setState(() {
                visit = index;
              }),
              styleDivider: StyleDivider.bottom,
              countStyle:const CountStyle(
                background: Colors.white,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: height),
            BottomBarSalomon(
              items: items,
              color: Colors.blue,
              backgroundColor: Colors.white,
              colorSelected: Colors.white,
              backgroundSelected: Colors.blue,
              borderRadius: BorderRadius.circular(0),
              indexSelected: visit,
              onTap: (index) => setState(() {
                visit = index;
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding:const EdgeInsets.only(bottom: 30, right: 32, left: 32),
        child: BottomBarFloating(
          items: items,
          backgroundColor: Colors.green,
          color: Colors.white,
          colorSelected: Colors.orange,
          indexSelected: visit,
          paddingVertical: 24,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
      ),
    );
  }
}
