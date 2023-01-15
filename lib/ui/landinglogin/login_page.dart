import 'dart:async';

import 'package:duit.in/common/screensize.dart';
import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/widgets/customtextbutton.dart';

class LoginPage extends StatefulWidget{
  int viewState;
  LoginPage(
      {Key? key,
      required this.viewState,
      }) : super(key: key);

  @override

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passController = TextEditingController(text: '');
  final TextEditingController confpassController = TextEditingController(text: '');
  double entryheightval = 430;
  double currentOpacity = 1;

  Widget backButton(){
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      margin: EdgeInsets.only(left: 20, top: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 28,
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton(){
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state){
          if (state is AuthLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            width: 240,
            decoration: BoxDecoration(
              color: blue,
              border: Border.all(
                color: black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(200)
            ),
            child: TextButton(
                onPressed: (){
                  context.read<AuthCubit>().signIn(
                      email: emailController.text,
                      password: passController.text);
                },
                child: Text(
                  "Login",
                  style: defaultTextTheme.copyWith(
                      fontSize: 16
                  ),
                )
            ),
          );
        },
        listener: (context, state){
          if (state is AuthSuccess){
            context.read<LogReaderCubit>().readLogs(state.user.uid);
            Navigator.pushNamedAndRemoveUntil(
                context, '/nav-page', (route) => false);
          } else if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
          }
        }
    );
  }

  Widget signupButton(){
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state){
          if (state is AuthLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            width: 240,
            decoration: BoxDecoration(
                color: blue,
                border: Border.all(
                  color: black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(200)
            ),
            child: TextButton(
                onPressed: (){
                  context.read<AuthCubit>().signUp(
                      name: nameController.text,
                      email: emailController.text,
                      password: passController.text,
                      confpass: confpassController.text);
                },
                child: Text(
                  "Sign up",
                  style: defaultTextTheme.copyWith(
                      fontSize: 16
                  ),
                )
            ),
          );
        },
        listener: (context, state){
          if (state is AuthSuccess){
            context.read<LogReaderCubit>().readLogs(state.user.uid);
            Navigator.pushNamedAndRemoveUntil(
                context, '/nav-page', (route) => false);
          } else if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
          }
        }
    );
  }

  final titlebarText = [
    nullWidget,
    Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 45),
      alignment: Alignment.topCenter,
      child: Text(
        "Sign up",
        style: defaultTextTheme.copyWith(
            fontSize: 26
        ),
      ),
    )
  ];
  int currentTitlebarText = 0;

  Widget titleBar(){
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: AnimatedOpacity(
        opacity: currentOpacity,
        duration: Duration(milliseconds: 100),
        child: titlebarText[currentTitlebarText],
      ),
    );
  }

  Widget logintopBody(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text("Login", style: defaultTextTheme.copyWith(fontSize: 30),),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: emailController,
              obscureText: false,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: passController,
              obscureText: true,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget loginBody(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logintopBody(),
        loginButton(),
        SizedBox(height: 10,),

        CustomTextButton(
            borderWidth: 0,
            borderColor: Colors.transparent,
            widthVal: 230,
            heightVal: 30,
            onPressed: (){
              toSignup();
            },
            buttonColor: Colors.transparent,
            text: 'Don\'t have an account? Sign up',
            textSize: 12,
            textColor: black),
        SizedBox(height: 80,),
      ],
    );
  }

  Widget signuptopBody(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Text("Register", style: defaultTextTheme.copyWith(fontSize: 30),),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: nameController,
              obscureText: false,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: emailController,
              obscureText: false,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: passController,
              obscureText: true,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 300,
            height: 50,
            child: TextFormField(
              controller: confpassController,
              obscureText: true,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  Widget signupBody(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        signuptopBody(),
        signupButton(),
        SizedBox(height: 10,),

        CustomTextButton(
            borderWidth: 0,
            borderColor: Colors.transparent,
            widthVal: 230,
            heightVal: 30,
            onPressed: (){
              toLogin();
            },
            buttonColor: Colors.transparent,
            text: 'Already have an account? Sign in',
            textSize: 12,
            textColor: black),
        SizedBox(height: 30),
      ],
    );
  }

  void toLogin(){
    setState(() {
      currentOpacity = 0;
      entryheightval = 425;
    });
    Timer(Duration(milliseconds: 100), (){
      setState(() {
        entryBodyCurrent = 0;
      });
    });
    Timer(Duration(milliseconds: 300), (){
      setState(() {
        currentTitlebarText = 0;
        currentOpacity = 1;
      });
    });
  }

  void toSignup(){
    setState(() {
      entryheightval = ScreenSize.height - 150;
      currentOpacity = 0;
    });
    Timer(Duration(milliseconds: 300), (){
      setState(() {
        entryBodyCurrent = 1;
        currentTitlebarText = 1;
        currentOpacity = 1;
      });
    });
  }

  late final entryBody = [
    loginBody(),
    signupBody(),
  ];
  int entryBodyCurrent = 0;

  Widget entryBox(){
    return AnimatedContainer(
      height: entryheightval,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
      ),
      duration: Duration(milliseconds: 200),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedOpacity(
              opacity: currentOpacity,
              duration: Duration(milliseconds: 100),
              child: entryBody[entryBodyCurrent])
        ],
      )
    );
  }

  Widget displayBody(){
    return Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: blue
            ),
          ),
          titleBar(),

          backButton(),
          entryBox(),
        ],
    );
  }

  @override
  void initState(){
    if (widget.viewState == 1){
      setState(() {
        entryheightval = ScreenSize.height - 150;
        entryBodyCurrent = 1;
        currentTitlebarText = 1;
        currentOpacity = 1;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: displayBody(),
    );
  }
}
