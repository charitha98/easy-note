import 'package:flutter/material.dart';

class Loading extends StatelessWidget{

  Widget build(BuildContext context){
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }
}