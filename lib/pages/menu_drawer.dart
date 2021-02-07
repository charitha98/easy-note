import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget{

  Widget build(BuildContext context){

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(40),
            color: Theme.of(context).primaryColor,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text(
              'All Notes',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text(
              'Favourites',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}