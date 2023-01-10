import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';

class AboutSettingsPage extends StatefulWidget{
  const AboutSettingsPage({Key? key}) : super(key: key);

  @override
  State<AboutSettingsPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutSettingsPage>{
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
            child: Text('About', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
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
            ],
          ),
        )
    );
  }
}
