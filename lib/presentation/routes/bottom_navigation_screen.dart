import 'package:flutter/material.dart';
import 'package:giripet_mobile/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:giripet_mobile/presentation/screens/login/login_screen.dart';
import 'package:giripet_mobile/presentation/screens/pets/pets_screen.dart';
import 'package:giripet_mobile/presentation/screens/profile_menu/profile_menu_screen.dart';
import 'package:giripet_mobile/presentation/screens/register/register_screen.dart';

class BottomNavigationController extends StatefulWidget {
  const BottomNavigationController({super.key});

  @override
  State<BottomNavigationController> createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    PetsScreen(),
    ProfileMenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk), label: 'Walks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
