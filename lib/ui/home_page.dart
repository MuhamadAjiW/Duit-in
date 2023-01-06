import 'package:flutter/material.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/widgets/textbutton.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void doNothing(){
  print("You pressed a button!");
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1,),
            Text('Hello ', style: defaultTextTheme.copyWith(
              fontSize: 26, fontWeight: medium,
            )),
            Spacer(flex: 8,),
          ],
        ),
      ),
    );
  }
}
