import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';
import 'package:liburan/cubit/log_reader_cubit.dart';
import 'package:liburan/theme/theme.dart';

import 'package:liburan/ui/home_page.dart';
import 'package:liburan/ui/data_page.dart';
import 'package:liburan/ui/logs_page.dart';
import 'package:liburan/ui/settings_page.dart';
import 'package:liburan/widgets/customfloatingbutton.dart';

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

  void onLogPressed<AuthCubit, AuthState>(String uid){
    context.read<LogReaderCubit>().readLogs(uid);
  }

  void onSettingsPressed(){
    //placeholder
  }

  Widget bottomNavBar(){
    return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state){
          if(state is AuthSuccess){
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
                  switch (index){
                    case 2: {
                      onLogPressed(state.user.uid);
                    }
                  }
                });
              },);
          }

          else{
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
        }
    );
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
      bottomNavigationBar: bottomNavBar(),
      floatingActionButton: floatingTab[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: white,
      body: tabs[currentIndex],
    );
  }
}

