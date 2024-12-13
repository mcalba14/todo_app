import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/dashboard_page.dart';
import 'package:todo_app/ui/screens/profile_page.dart';
import 'package:todo_app/ui/screens/task_page.dart';
import 'package:todo_app/ui/screens/widgets/dashboard_widget.dart';
import 'package:todo_app/ui/screens/widgets/profile_widget.dart';
import 'package:todo_app/ui/screens/widgets/task_widget.dart';

class RootPage extends StatefulWidget {
  const RootPage({required this.userId, super.key});

  final int userId;

  @override
  State<RootPage> createState() => _RootPageState(userId);
}

class _RootPageState extends State<RootPage> {
  final int userId;
  int _selectedIndex = 0;

  _RootPageState(this.userId);

  List<Widget> _widgetList() {
    return [
      DashboardPage(userId: userId),
      TaskPage(userId: userId),
      ProfilePage(userId: userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetList(),
      ),
      // body: Center(
      //     child: Text("Selected Page: ${_navBarItems[_selectedIndex].label}")),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: _navBarItems,
      ),
    );
  }
}

const _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.dashboard_customize_outlined),
    selectedIcon: Icon(Icons.dashboard_customize_rounded),
    label: 'Dashboard',
  ),
  NavigationDestination(
    icon: Icon(Icons.list_outlined),
    selectedIcon: Icon(Icons.list_rounded),
    label: 'Tasks',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Profile',
  ),
];
