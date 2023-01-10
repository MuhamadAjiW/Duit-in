import 'package:duit.in/ui/settings_about_page.dart';
import 'package:flutter/material.dart';

import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/widgets/customsettingsbutton.dart';


import 'package:duit.in/ui/settings_profile_page.dart';
import 'package:duit.in/ui/settings_contents_page.dart';
import 'package:duit.in/ui/settings_notifications_page.dart';
import 'package:duit.in/ui/settings_security_page.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text('Settings', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
          Spacer(),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(logoItb))
            ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Text("Account Settings",
                    style: defaultTextTheme.copyWith(
                      fontSize: 20,
                      fontWeight: regular,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      SettingsButton(
                        buttonText: "Profile Information",
                        buttonDesc: "Manage profile",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        imagefile: logoItb,
                      ),
                      SettingsButton(
                        buttonText: "Contents",
                        buttonDesc: "Control viewed contents",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContentsPage()));
                        },
                        imagefile: logoItb,
                      ),
                      SettingsButton(
                        buttonText: "Security",
                        buttonDesc: "Change your password",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecurityPage()));
                        },
                        imagefile: logoItb,
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Notification Settings",
                    style: defaultTextTheme.copyWith(
                      fontSize: 20,
                      fontWeight: regular,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      SettingsButton(
                        buttonText: "Notifications",
                        buttonDesc: "Receive proper notifications",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsPage()));
                        },
                        imagefile: logoItb,
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Others",
                    style: defaultTextTheme.copyWith(
                      fontSize: 20,
                      fontWeight: regular,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      SettingsButton(
                        buttonText: "About",
                        buttonDesc: "Application Information",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutSettingsPage()));
                        },
                        imagefile: logoItb,
                      ),
                    ],
                  )),
            ])));
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 60,),
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
    );
  }
}

