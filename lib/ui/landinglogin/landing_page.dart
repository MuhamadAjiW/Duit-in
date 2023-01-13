
import 'package:duit.in/ui/landinglogin/login_page.dart';
import 'package:flutter/material.dart';

import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/widgets/customtextbutton.dart';

class LandingPage extends StatefulWidget{
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>{
  
  Widget loginButton(){
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(viewState: 1)));
          },
          child: Text(
            "Create Account",
            style: defaultTextTheme.copyWith(
                fontSize: 16
            ),
          )
      ),
    );
  }
  
  Widget registerButton(){
    return Container(
      width: 240,
      decoration: BoxDecoration(
          color: white,
          border: Border.all(
            color: black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(200)
      ),
      child: TextButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(viewState: 0)));
          },
          child: Text(
            "Login",
            style: defaultTextTheme.copyWith(
                fontSize: 16
            ),
          )
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 8),
              Text("Let's get started",
                style: defaultTextTheme.copyWith(
                  fontSize: 22,
                  color: blue
                ),
              ),
              SizedBox(height: 20,),
              Text("Let's get started with duit.in",
                style: defaultTextTheme.copyWith(),
              ),
              Spacer(flex: 5),
              loginButton(),
              SizedBox(height: 10,),
              registerButton(),
              Spacer(flex: 5)
            ],
          ),
        ),
      ),
    );
  }
}
