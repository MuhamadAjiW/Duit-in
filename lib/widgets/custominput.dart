
import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';

class CustomInputBar extends StatelessWidget{
  final String text;
  final String hint;
  final String imagefile;
  final bool obscuretext;
  final TextEditingController controller;

  const CustomInputBar(
      {Key? key,
      this.text = '',
      this.hint = '',
      this.obscuretext = false,
      required this.controller,
      required this.imagefile})
      : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: 300,
      height: 50,
      child:
      Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagefile))
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child:
            TextFormField(
              controller: controller,
              obscureText: obscuretext,
              cursorColor: black,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: defaultTextTheme,
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))
                  )
              ),
            )
          )
        ],
      ),
    );
  }
}