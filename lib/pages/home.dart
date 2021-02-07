import 'package:easy_note/main.dart';
import 'package:easy_note/models/note.dart';
import 'package:easy_note/pages/new.dart';
import 'package:easy_note/service/db.dart';
import 'package:easy_note/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit.dart';
import 'menu_drawer.dart';

class Home extends StatefulWidget{
  State createState() => HomeState();
}

class HomeState extends State<Home>{

  List<Note> notes;
  List<Note> notesForDisplay = List<Note>();
  bool loading = true, isSearching = false;
  bool ascOrder = true;

  void initState(){
    setState(() {
      notesForDisplay = notes;
    });
    super.initState();
    refresh();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
          ? Text('All Notes')
          : TextField(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),
              onChanged: (text){
                text = text.toLowerCase();
                setState(() {
                  notes = notes.where((note){
                    var noteTitle = note.title.toLowerCase();
                    return noteTitle.contains(text);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                    Icons.search,
                    color: Colors.white,),
                hintText: 'Search by title',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                )),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    this.isSearching = !this.isSearching;
                  });
                },
                child: isSearching ?
                IconButton(
                  icon: Icon(Icons.cancel,size: 26.0),
                  onPressed: (){
                    setState(() {
                      refresh();
                      isSearching =! isSearching;
                    });
                  },
                )
                : Icon(
                  Icons.search,
                  size: 26.0,
                )
              )
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: (){
              sortDialog(context);
            },
          ),
        ],
      ),

      drawer: MenuDrawer(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() => loading = true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => New(note: new Note()))).then((v){
            refresh();
          });
        },
      ),

      body: loading? Loading() : ListView.builder(
         // reverse: order,
        padding: EdgeInsets.all(5.0),
        itemCount: notes.length,
        itemBuilder: (context, index){
          Note note = notes[index];
          return Card(
            color: Colors.white70,
            child: ListTile(
              title: Text(note.title),
              leading: Container(
                width: 85,
                margin: EdgeInsets.only(top: 12,right: 25),
                child: FittedBox(
                  child: Text(
                    note.date.toString(),
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
              subtitle: Text(
                  note.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.library_books),
              onTap: (){
                setState(() => loading = true);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(note: note))).then((v) {
                  refresh();
                });
              },
            ),
          );
        }
      ),
    );
  }

  sortDialog(BuildContext context){

    TextEditingController customController = TextEditingController();

    return showDialog(context: context,builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 150,
          width: 200,
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Sort by title   A - Z', textScaleFactor: 1.1, textAlign: TextAlign.center,),
                trailing: Icon(Icons.keyboard_arrow_up),
                onTap: (){
                  setState(() {
                   if(ascOrder == false){
                     notes = notes.reversed.toList();
                     ascOrder = true;
                   }
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text('Sort by title   Z - A', textScaleFactor: 1.1, textAlign: TextAlign.center),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: (){
                  setState(() {
                    if(ascOrder == true){
                      notes = notes.reversed.toList();
                      ascOrder = false;
                    }
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        ),
      );
    });

  }

  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() => loading = false);
  }
}