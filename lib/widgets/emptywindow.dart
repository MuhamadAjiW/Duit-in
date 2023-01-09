import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';

class EmptyWinPage extends StatefulWidget{
  const EmptyWinPage({Key? key}) : super(key: key);
  @override
  State<EmptyWinPage> createState() => _PageState();
}

class _PageState extends State<EmptyWinPage>{
  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Work in Progress', style: defaultTextTheme.copyWith(
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

