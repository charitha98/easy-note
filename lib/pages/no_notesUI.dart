import 'package:easy_note/models/note.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'new.dart';

class noNotesHome extends StatefulWidget{

  Widget noNotesUI(BuildContext context){
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                'crying_emoji.png',
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
              ),
            ),
            RichText(
              text: TextSpan(
                //style:
                  children: [
                    TextSpan(text: ' There is no note available\n Tap on "'),
                    TextSpan(text: '+',
                        //style: boldPlus,
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            goToNewNoteScreen(context);
                          }
                    ),
                    TextSpan(text: '" to add new note.')
                  ]
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

  void goToNewNoteScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => New(note: new Note()))).then((v){
      //refresh();
    });
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}