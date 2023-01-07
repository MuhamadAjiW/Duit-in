import 'package:flutter/material.dart';
import 'package:liburan/theme/theme.dart';

import 'package:liburan/ui/home_page.dart';
import 'package:liburan/ui/data_page.dart';
import 'package:liburan/ui/logs_page.dart';
import 'package:liburan/ui/profile_page.dart';

class NavPage extends StatefulWidget{
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavState();
}

void doNothing(){
  print("You pressed a button!");
}

Widget createLogButton(){
  return Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 10),
      child: FloatingActionButton(
        backgroundColor: blue,
        child: Icon(Icons.add),
        onPressed: (){
          doNothing();
        },
      )
  );
}

class _NavState extends State<NavPage>{
  int currentIndex = 0;

  Widget bottomNavBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled)),
        BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: 'Data',
            activeIcon: Icon(Icons.auto_graph)),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            label: 'Logs',
            activeIcon: Icon(Icons.receipt_sharp)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            activeIcon: Icon(Icons.person)),
      ],
      onTap: (index){
        setState((){
          currentIndex = index;
        });
      },);
  }

  final tabs = [
    HomePage(),
    DataPage(),
    LogsPage(),
    ProfilePage(),
  ];

  final floatingTab = [
    createLogButton(),
    nullWidget,
    nullWidget,
    nullWidget,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      floatingActionButton: floatingTab[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: white,
      body: tabs[currentIndex],
    );
  }
}

