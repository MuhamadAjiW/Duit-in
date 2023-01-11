
import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';

class CustomLogButton extends StatelessWidget {
  final String buttonText;
  final String value;
  final String timeMarker;
  final Function() onPressed;
  final bool isIncome;

  const CustomLogButton({
    Key? key,
    required this.buttonText,
    required this.value,
    required this.timeMarker,
    required this.onPressed,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagefile = logoItb;
    if (this.isIncome){
      imagefile = logoItb;
    }

    Widget subContainer(){
      return Container(
          width: double.infinity,
          height: 80,
          child: TextButton(
              onPressed: onPressed,
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(imagefile))),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              buttonText,
                              style: defaultTextTheme.copyWith(
                                fontSize: 18,
                                fontWeight: regular,
                              ),
                            ),
                            Spacer(),
                            Text(
                              timeMarker,
                              style: grayTextTheme.copyWith(
                                fontSize: 12,
                                fontWeight: light,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Text(
                          value,
                          style: grayTextTheme.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                    ],
                  )
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                  )
              )
          )
      );
    }

    return Container(
      child: Column(
        children: [
          subContainer(),
          Divider(
            height: 1,
            thickness: 1,
            color: gray,

          )
        ],
      ),
    );

  }
}
