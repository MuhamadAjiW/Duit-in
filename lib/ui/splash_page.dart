import 'dart:async';

import 'package:duit.in/common/screensize.dart';
import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  double currentOpacity = 0;

  @override
  void initState(){
    currentOpacity = 1;
    Timer(const Duration(seconds: 2), (){
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null){
        Navigator.pushNamedAndRemoveUntil(
            context, '/landing-page', (route) => false);
      }
      else {
        context.read<LogReaderCubit>().readLogs(user.uid);
        context.read<AuthCubit>().getCurrentUser(user.uid);
        Navigator.pushNamedAndRemoveUntil(
            context, '/nav-page', (route) => false);
      }
    });
  }

  Widget build(BuildContext context) {
    ScreenSize.width = MediaQuery.of(context).size.width;
    ScreenSize.height= MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: white,
        body: AnimatedOpacity(
          opacity: currentOpacity,
          duration: Duration(milliseconds: 1000),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(logoItb),
                fit: BoxFit.contain
              ),
            ),
          ),
        )
    );
  }
}
