import 'package:flutter/material.dart';
import 'package:liburan/theme/theme.dart';

class SettingsButton extends StatelessWidget {
  final String buttonText;
  final String buttonDesc;
  final Function() onPressed;
  final String imagefile;

  const SettingsButton({
    Key? key,
    this.buttonText = '',
    this.buttonDesc = '',
    required this.onPressed,
    required this.imagefile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            buttonDesc,
                            style: grayTextTheme.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )
                  ],
                )),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)))));
  }
}
