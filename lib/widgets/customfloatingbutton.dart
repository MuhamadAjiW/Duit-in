import 'package:flutter/material.dart';
import 'package:liburan/theme/theme.dart';
import 'package:liburan/ui/add_log_page.dart';

class customfloatingButton extends StatefulWidget{
  const customfloatingButton({Key? key}) : super(key: key);
  @override
  State<customfloatingButton> createState() => _customfloatingButtonState();
}

class _customfloatingButtonState extends State<customfloatingButton>{
  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingActionButton(
          backgroundColor: blue,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddLogPage()));
          },
        )
    );
  }
}