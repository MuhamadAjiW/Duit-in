import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';

import 'package:duit.in/ui/home_page.dart';
import 'package:duit.in/ui/data_page.dart';
import 'package:duit.in/ui/logs_page.dart';
import 'package:duit.in/ui/settings_page.dart';
import 'package:duit.in/widgets/customfloatingbutton.dart';

class NavPage extends StatefulWidget{
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavState();
}

class _NavState extends State<NavPage>{
  int currentIndex = 0;

  void onHomePressed(){
    //placeholder
  }

  void onGraphPressed(){
    //placeholder
  }

  void onLogPressed(String uid){

  }

  void onSettingsPressed(){
    //placeholder
  }

  Widget bottomNavBarAlt(){
    return NavigationBar(
      height: 70,
      backgroundColor: Colors.white,
      selectedIndex: currentIndex,
      destinations: [
        NavigationDestination(
            icon: Icon(
                Icons.home_outlined,
                color: gray,
                size: 30,
            ),
            label: 'Home',
            selectedIcon: Icon(
                Icons.home_filled,
                color: blue,
                size: 30,
            )),
        NavigationDestination(
            icon: Icon(
                Icons.auto_graph_outlined,
                color: gray,
                size: 30,
            ),
            label: 'Data',
            selectedIcon: Icon(
                Icons.auto_graph,
                color: blue,
                size: 30,
            )),
        NavigationDestination(
            icon: Icon(
                Icons.receipt_outlined,
                color: gray,
                size: 30,
            ),
            label: 'Logs',
            selectedIcon: Icon(
                Icons.receipt_sharp,
                color: blue,
                size: 30,
            )),
        NavigationDestination(
            icon: Icon(
                Icons.settings,
                color: gray,
                size: 30,
            ),
            label: 'Settings',
            selectedIcon: Icon(
              Icons.settings,
              color: blue,
              size: 30,
            )),
      ],
      onDestinationSelected: (index){
        setState((){
          currentIndex = index;
        });
      },
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    );
  }

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
                    icon: Icon(Icons.settings),
                    label: 'Settings'),
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
    SettingsPage(),
  ];

  final floatingTab = [
    customfloatingButton(),
    nullWidget,
    nullWidget,
    nullWidget,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBarAlt(),
      floatingActionButton: floatingTab[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: white,
      body: tabs[currentIndex],
    );
  }
}

