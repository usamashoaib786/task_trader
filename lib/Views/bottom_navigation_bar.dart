import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Views/add_rule.dart';
import 'package:task_trader/Views/homeScreen.dart';
import 'package:task_trader/Views/profile.dart';

class BottomNavView extends StatefulWidget {
  final bool? showPopup;
  const BottomNavView({super.key, this.showPopup});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  List<Widget> _screens = [];
  @override
  void initState() {
    super.initState();
    _screens = [const AddNewRule(), HomeScreen(), Profile()];
  }

  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 75,
        animationCurve: Curves.easeOut,
        animationDuration: Duration(milliseconds: 400),
        color: Color(0xff393A65), // Semi-transparent background
        backgroundColor: Colors.black,
        index: _currentIndex,
        items: <Widget>[
          Icon(
            Icons.rule,
            color: AppTheme.white,
            size: 30,
          ),
          Icon(
            Icons.home_filled,
            color: AppTheme.white,
            size: 30,
          ),
          Icon(
            Icons.person,
            color: AppTheme.white,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _screens[_currentIndex],
    );
  }
}
