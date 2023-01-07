import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget{
  const EmptyPage({Key? key}) : super(key: key);

  @override
  State<EmptyPage> createState() => _PageState();
}


class _PageState extends State<EmptyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center()
    );
  }
}
