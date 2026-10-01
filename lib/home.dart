import 'package:flutter/material.dart';
import 'package:isar_expense_tracker/widgets/expense_gallery.dart';
import 'package:isar_expense_tracker/widgets/expense_home.dart';
import 'package:isar_expense_tracker/widgets/expense_screen.dart';
import 'package:isar_expense_tracker/widgets/expense_settings.dart';
import 'package:isar_expense_tracker/widgets/expense_states.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: IndexedStack(
              index: _currentIndex,
              children: [
                ExpenseHome(),
                ExpenseScreen(),
                ExpenseStates(),
                ExpenseGallery(),
                ExpenseSettings(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        items: [
          createBottomBarItem(Icons.home, 'Home'),
          createBottomBarItem(Icons.add, 'Expense'),
          createBottomBarItem(Icons.show_chart, 'States'),
          createBottomBarItem(Icons.browse_gallery, 'Gallery'),
          createBottomBarItem(Icons.settings, 'Settings'),
        ],
        onTap: (nextIndex) {
          _currentIndex = nextIndex;
          setState(() {});
        },
      ),
    );
  }

  SalomonBottomBarItem createBottomBarItem(IconData icon, String iconText) {
    return SalomonBottomBarItem(
      icon: Icon(icon),
      title: Text(iconText),
      selectedColor: Colors.teal,
    );
  }
}
