import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const BaseScreen({
    Key? key,
    required this.child,
    required this.currentIndex,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : super(key: key);

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/addWorkout');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/stopwatch');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xFF121212),
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF1E1E2C),
        buttonBackgroundColor: selectedItemColor ?? const Color(0xFF00BFA5),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) => _onTabTapped(context, index),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.timer, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
