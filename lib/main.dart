import 'package:easy_note/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(EasyNote());

class EasyNote extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'EasyNote',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}