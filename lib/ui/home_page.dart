import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';

import 'package:liburan/theme/theme.dart';

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
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello ', style: defaultTextTheme.copyWith(
                fontSize: 26,
                fontWeight: light,
              )),
              SizedBox(height: 10,),
              Text('${state.user.name}', style: defaultTextTheme.copyWith(
                fontSize: 26,
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
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1,),
            openingPlate(),
            Spacer(flex: 8,),
          ],
        ),
    );
  }
}
