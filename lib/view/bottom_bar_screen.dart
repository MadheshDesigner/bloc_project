import 'package:flutter/material.dart';
import '../../view/add_item/item_view_screen.dart';
import '../../view/item/item_list_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int currentIndex = 0;
  final List<Widget> _screenList = [
    ItemListScreen(),
    ItemViewScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "Remote data"),
            BottomNavigationBarItem(icon:Icon(Icons.category),label: "Dynamic data"),
          ]),
      body: _screenList[currentIndex],
    );
  }
}
