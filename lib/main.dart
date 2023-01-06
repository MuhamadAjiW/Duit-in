//import dari third party
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import cubit
import 'package:liburan/cubit/testcubit.dart';
import 'package:liburan/cubit/auth_cubit.dart';

//import ui
import 'package:liburan/ui/splash_page.dart';
import 'package:liburan/ui/home_page.dart';
import 'package:liburan/ui/landing_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (context) => TestCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home-page': (context) => HomePage(),
          '/landing-page': (context) => LandingPage()
        },
      )
    );
  }
}
