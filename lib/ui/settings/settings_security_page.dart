import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/ui/settings/settings_change_pass.dart';
import 'package:duit.in/widgets/customsettingsbutton.dart';

class SecurityPage extends StatefulWidget{
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage>{
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
            child: Text('Security', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }


  Widget settingsList() {
    return Container(
        width: double.infinity,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      SettingsButton(
                        buttonText: "Change Password",
                        buttonDesc: "Change your password",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PassChangePage()));
                        },
                        imagefile: logoItb,
                      ),
                    ],
                  )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: openingPlate(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              child: Column(
                children: [
                  settingsList(),
                ],
              ),
            )
          ],
        )
    );
  }
}
