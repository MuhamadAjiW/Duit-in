import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';


class CustomTextButton extends StatelessWidget {

  final TextStyle textStyle = defaultTextTheme;

  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final double heightVal;
  final double widthVal;
  final double borderWidth;
  final String text;
  final double textSize;
  final FontWeight textWeight;
  final Function() onPressed;

  CustomTextButton({Key? key,
    required this.heightVal,
    required this.widthVal,
    required this.onPressed,

    this.buttonColor = black,
    this.textColor = black,
    this.borderColor = black,
    this.borderWidth = 0,
    this.text = '',
    this.textSize = 12,
    this.textWeight = light
  }) : super(key: key);

  void buttonAnimation(Function onPressed){
  }


  @override
  Widget build(BuildContext context){
    return Container(
      width: widthVal,
      height: heightVal,

      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
          width: borderWidth
        )
      ),

      child: TextButton(
        onPressed: onPressed,

        child: Center(
          child:
          Text(text,
            style: textStyle.copyWith(
              fontSize: textSize,
              fontWeight: textWeight,
              color: textColor)
            ),
          ),
      )

    );
  }
}