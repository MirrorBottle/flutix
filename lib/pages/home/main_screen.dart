import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/pages/home/home_screen.dart';
import 'package:flutix/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const HomeScreen(),
    const Center(child: Text("1")),
    ProfileScreen(),
    const Center(child: Text("3")),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        backgroundColor: constSecondaryColor,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.dashboard, size: 30),
            title: const Text('Home',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            activeColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.confirmation_num, size: 30),
            title: const Text('Ticket',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            activeColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.account_circle, size: 30),
            title: const Text('Profile',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
