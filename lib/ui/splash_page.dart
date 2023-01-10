import 'dart:async';

import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';

const int delay = 1;

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: delay),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad
  );

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState(){
    Timer(const Duration(seconds: delay), (){
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

      Navigator.pushNamedAndRemoveUntil(
          context, '/landing-page', (route) => false);

    });
    super.initState();
  }

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(logoItb),
                    fit: BoxFit.contain
                )
            ),
          ),
        ),
      ),
    );

  }
}
