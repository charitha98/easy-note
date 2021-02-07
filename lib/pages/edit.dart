import 'package:easy_note/models/note.dart';
import 'package:easy_note/service/db.dart';
import 'package:easy_note/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget{

  final Note note;
  Edit({ this.note});

  EditState createState() => EditState();
}

class EditState extends State<Edit>{

  TextEditingController title, content;
  bool loading = false, isFavorite = false, starred = false;
  File file;

  void pickImage() async{
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    file = File(pickedFile.path);
    setState(() {

    });
  }

  void initState(){
    super.initState();
    title = new TextEditingController();
    content = new TextEditingController();
    //isFavorite = false;

    if(widget.note.id != null){
      title.text = widget.note.title;
      content.text = widget.note.content;
      //isFavorite = widget.note.isFavourite;
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: pickImage,
          ),
          IconButton(
            icon: Icon(!isFavorite
                ? Icons.star_border
                : Icons.star),
            onPressed: () {
              setState(() {
                this.isFavorite = !this.isFavorite;
                isStarred();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() => loading = true);
              save();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              createAlertDialog(context);
            },
          )
        ],
      ),

      body: loading? Loading() : ListView(
        padding: EdgeInsets.all(13.0),
        children: <Widget>[
          TextField(
              decoration: InputDecoration(
                  hintText: 'Title'
              ),
              controller: title
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Notes'
            ),
            controller: content,
            maxLines: 5,
          ),
          if(file != null) Image.file(file),
        ],
      ),
    );
  }

  createAlertDialog(BuildContext context){

    TextEditingController customController = TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Delete?"),
        content: Text("Do you want to delete the note?"),
        actions: <Widget>[
          MaterialButton(
            //elevation: 1.0,
            child: Text('Yes'),
            onPressed: (){
              //setState(() => loading = true);
              delete();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            //elevation: 1.0,
            child: Text('No'),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    });
  }

  Future<void> save() async {
    if(title.text != ''){
      widget.note.title = title.text;
      widget.note.content = content.text;
      //widget.note.file = file;
      //widget.note.isFavourite = starred;

      await DB().update(widget.note);

    }
    setState(() => loading = false);
    Navigator.pop(context);
  }

  Future<void> delete() async {
    await DB().delete(widget.note);
    setState(() => loading = false);
    Navigator.pop(context);
  }

  Future<void> isStarred() async{

    if(isFavorite == false){
      starred = false;
    }
    else{
      starred = true;
    }

  }
}