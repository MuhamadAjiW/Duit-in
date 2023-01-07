import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';

import 'package:liburan/theme/theme.dart';

class LogsPage extends StatefulWidget{
  const LogsPage({Key? key}) : super(key: key);
  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>{
  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logs', style: defaultTextTheme.copyWith(
            fontSize: 32,
            fontWeight: light,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 1,),
          openingPlate(),
          Spacer(flex: 8,),
        ],
      ),
    );
  }
}

