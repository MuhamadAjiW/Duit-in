import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/widgets/customtextbutton.dart';

class PassChangePage extends StatefulWidget{
  const PassChangePage({Key? key}) : super(key: key);

  @override
  State<PassChangePage> createState() => _PassChangePageState();
}

class _PassChangePageState extends State<PassChangePage>{
  final TextEditingController oldPassController = TextEditingController(text: '');
  final TextEditingController newPassController = TextEditingController(text: '');
  final TextEditingController confirmPassController = TextEditingController(text: '');

  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 28,
              color: black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text('Change Password', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget inputOldPass(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: oldPassController,
          obscureText: true,
          cursorColor: black,
          decoration: InputDecoration(
              hintText: 'Old Password',
              hintStyle: defaultTextTheme,
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15))
              )
          ),
        )
    );
  }

  Widget inputNewPass(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: newPassController,
          obscureText: true,
          cursorColor: black,
          decoration: InputDecoration(
              hintText: 'New Password',
              hintStyle: defaultTextTheme,
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15))
              )
          ),
        )
    );
  }

  Widget confirmNewPass(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: confirmPassController,
          obscureText: true,
          cursorColor: black,
          decoration: InputDecoration(
              hintText: 'Confirm New Password',
              hintStyle: defaultTextTheme,
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15))
              )
          ),
        )
    );
  }

  Widget submitButton(){
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state){
          if (state is AuthLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is AuthSuccess){
            return CustomTextButton(
              widthVal: 300,
              heightVal: 50,
              buttonColor: Colors.transparent,
              text: 'Save',
              textSize: 12,
              textColor: black,
              onPressed: (){
                context.read<AuthCubit>().updatePass(
                    oldUser: state.user,
                    oldPass: oldPassController.text,
                    newPass: newPassController.text,
                    confPass : confirmPassController.text
                );
              },
            );
          }
          else{
            return CustomTextButton(
              widthVal: 300,
              heightVal: 50,
              buttonColor: Colors.transparent,
              text: 'Save',
              textSize: 12,
              textColor: black,
              onPressed: (){
                print("Please Wait...");
              },
            );
          }
        },
        listener: (context, state){
          if (state is AuthInitial){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Password has been changed"),
              backgroundColor: green,
            ));
            Navigator.pushNamedAndRemoveUntil(
                context, '/landing-page', (route) => false);
          } else if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 60,),
              openingPlate(),
              SizedBox(height: 30,),
              inputOldPass(),
              SizedBox(height: 30,),
              inputNewPass(),
              SizedBox(height: 30,),
              confirmNewPass(),
              SizedBox(height: 30,),
              submitButton(),
            ],
          ),
        )
    );
  }
}
