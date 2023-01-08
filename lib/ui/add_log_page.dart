import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';
import 'package:liburan/cubit/log_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/widgets/customtextbutton.dart';

class AddLogPage extends StatefulWidget{
  const AddLogPage({Key? key}) : super(key: key);

  @override
  State<AddLogPage> createState() => _AddLogState();
}

class _AddLogState extends State<AddLogPage>{
  final TextEditingController testController = TextEditingController(text: '');

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
            child: Text('Add Log', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget submitLogButton(){
    return BlocConsumer<LogCubit, LogState>(
        builder: (context, state){
          if (state is LogLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is LogInitial){
            return CustomTextButton(
              widthVal: 300,
              heightVal: 50,
              buttonColor: Colors.transparent,
              text: 'Save',
              textSize: 12,
              textColor: black,
              onPressed: (){
                // TODO: Implement add log function
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
                print("Please wait...");
              },
            );
          }
        },
        listener: (context, state){}
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
              submitLogButton(),
            ],
          ),
        )
    );
  }
}
