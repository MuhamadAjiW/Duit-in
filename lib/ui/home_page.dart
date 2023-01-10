import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:duit.in/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  Widget openingPlate(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello ', style: defaultTextTheme.copyWith(
                fontSize: 32,
                fontWeight: light,
              )),
              SizedBox(height: 10,),
              Text('${state.user.name}', style: defaultTextTheme.copyWith(
                fontSize: 32,
                fontWeight: medium,
              )),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget spendingPlate(){
    return BlocBuilder<LogReaderCubit, LogReaderState>(builder: (context, state){
      if (state is LogReaderSuccess){
        int sum = getsumOfDay(state.logs);
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today you have spent: ', style: defaultTextTheme.copyWith(
                fontSize: 16,
                fontWeight: light,
              )),
              SizedBox(height: 10,),
              Text(currencyForm(sum.toString()), style: defaultTextTheme.copyWith(
                fontSize: 16,
                fontWeight: medium,
              )),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 60,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: openingPlate(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              spendingPlate(),
            ],
          ),
        )
      ],
    );
  }
}

