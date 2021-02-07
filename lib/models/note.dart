import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Note{

  int id, date;
  String title, content;
  //bool isFavourite;
  //File file;

  setDate(){
    DateTime now = DateTime.now();
    String ds = now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.minute.toString() + now.second.toString();
    date = int.parse(ds);
  }

  Note();

  Note.fromMap(Map<String, dynamic> map){
    id = map['id'];
    date = map['date'];
    title = map['title'];
    content = map['content'];
    //file = map['file'];
    //isFavourite = map['isFavourite'];
  }

  toMap(){
    return <String, dynamic>{
      'id' : id,
      'date' : date,
      'title' : title,
      'content' : content,
      //'file' : file,
      //'isFavourite' : isFavourite,
    };
  }

}