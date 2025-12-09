import 'package:flutter/material.dart';
import '../database/database.dart';
import 'home_screen.dart';
import 'likes_screen.dart';
import 'bag_screen.dart';
import 'transactions_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final AppDatabase database;
  final User currentUser;

  MainScreen({required this.database, required this.currentUser});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(database: widget.database),
      LikesScreen(database: widget.database),
      BagScreen(database: widget.database),
      TransactionsScreen(database: widget.database),
      ProfileScreen(database: widget.database, user: widget.currentUser),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Likes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Transactions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
