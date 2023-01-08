import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/widgets/customtextbutton.dart';

class NameChangePage extends StatefulWidget{
  const NameChangePage({Key? key}) : super(key: key);

  @override
  State<NameChangePage> createState() => _NameChangePageState();
}

class _NameChangePageState extends State<NameChangePage>{
  final TextEditingController nameController = TextEditingController(text: '');

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
            child: Text('Change Name', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget inputNewName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: nameController,
        obscureText: false,
        cursorColor: black,
        decoration: InputDecoration(
            hintText: 'New Name',
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
                context.read<AuthCubit>().updateName(
                    oldUser: state.user,
                    newName: nameController.text);
              },
            );
          }
          else{
            return nullWidget;
          }
        },
        listener: (context, state){
          if (state is AuthSuccess){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 60,),
              openingPlate(),
              SizedBox(height: 30,),
              inputNewName(),
              SizedBox(height: 30,),
              submitButton(),
            ],
          ),
        )
    );
  }
}
