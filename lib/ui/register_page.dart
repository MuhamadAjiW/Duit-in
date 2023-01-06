import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/ui/home_page.dart';
import 'package:liburan/ui/landing_page.dart';
import 'package:liburan/widgets/custominput.dart';
import 'package:liburan/widgets/textbutton.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    Widget submitButton(){
      return BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state){
            if (state is AuthLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomTextButton(
                widthVal: 300,
                heightVal: 50,
                buttonColor: Colors.transparent,
                text: 'Sign up',
                textSize: 12,
                textColor: black,
                onPressed: (){
                 context.read<AuthCubit>().signUp(
                     name: nameController.text,
                     email: emailController.text,
                     password: passController.text);
                },
            );
          },
          listener: (context, state){
            if (state is AuthSuccess){
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home_page', (route) => false);
            } else if (state is AuthFailed){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: red,
              ));
            }
          }
      );
    }

    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            children: [
              Spacer(flex: 6),
              Text("Register Page"),
              Spacer(flex: 8),

              CustomInputBar(
                  controller: nameController,
                  hint: 'Name',
                  imagefile: logoItb),
              Spacer(flex: 1),

              CustomInputBar(
                  controller: emailController,
                  hint: 'Email',
                  imagefile: logoItb),
              Spacer(flex: 1),

              CustomInputBar(
                controller: passController,
                hint: 'Password',
                imagefile: logoItb,
                obscuretext: true,),
              Spacer(flex: 1),

              submitButton(),
              Spacer(flex: 1),

              CustomTextButton(
                  widthVal: 300,
                  heightVal: 50,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                  buttonColor: Colors.transparent,
                  text: 'Already have an account? Sign in',
                  textSize: 12,
                  textColor: black),
              Spacer(flex: 4)
            ],
          ),
        ),
      ),
    );
  }
}
