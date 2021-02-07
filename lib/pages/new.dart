
import 'dart:io';
import 'package:easy_note/models/note.dart';
import 'package:easy_note/pages/home.dart';
import 'package:easy_note/service/db.dart';
import 'package:easy_note/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class New extends StatefulWidget{

  final Note note;
  New({ this.note});

  NewState createState() => NewState();
}

class NewState extends State<New>{

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

    if(widget.note.id != null){
      title.text = widget.note.title;
      content.text = widget.note.content;
      //isFavorite = widget.note.isFavourite;
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('New'),
        actions: <Widget>[
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
            icon: Icon(Icons.attach_file),
            onPressed: pickImage,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() => loading = true);
              save();
            },
          ),
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

  Future<void> save() async {
    if(title.text != ''){
      widget.note.title = title.text;
      widget.note.content = content.text;
      //widget.note.isFavourite = isFavorite;
      //widget.note.file = file;
      await DB().add(widget.note);
    }
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