
import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';

class CustomNavBar extends StatefulWidget{
  final String category1;
  final String category2;
  final String category3;
  final int ratio1;
  final int ratio2;
  final int ratio3;
  final int sideratio;
  final Function() onPressed1;
  final Function() onPressed2;
  final Function() onPressed3;
  const CustomNavBar(
      {Key? key,
        required this.category1,
        required this.category2,
        required this.category3,
        required this.ratio1,
        required this.ratio2,
        required this.ratio3,
        required this.sideratio,
        required this.onPressed1,
        required this.onPressed2,
        required this.onPressed3,
      }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _activeIndex = 0;

  Widget subContainer(
      String text,
      int ratio,
      Function() onpressed,
      int index,
      ){
    return Container(
        child: Expanded(
            flex: ratio,
            child: GestureDetector(
                onTap: (){
                  print(_activeIndex);
                  setState(() {
                    _activeIndex = index;
                  });
                  print(_activeIndex);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: black,
                          width: 1
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style:
                        (index == _activeIndex? defaultTextTheme.copyWith(fontSize: 17) : grayTextTheme.copyWith(fontSize: 17,)),
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color:
                        (index == _activeIndex? black : gray),
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
  Widget rightIndent(){
    return Container(
      child: Expanded(
        flex: widget.sideratio,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20,height: 29,),
            Divider(
              height: 1,
              thickness: 1,
              color: gray,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subContainer(widget.category1, widget.ratio1, widget.onPressed1, 0),
            subContainer(widget.category2, widget.ratio2, widget.onPressed2, 1),
            subContainer(widget.category3, widget.ratio3, widget.onPressed3, 2),
            rightIndent(),
          ],
        ),
    );
  }
}
