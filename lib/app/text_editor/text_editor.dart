import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joaog/OneDrive/Desenvolvimento/flutter_psychology/lib/app/shared/model/notes_model.dart';
import 'package:flutternotes/app/text_editor/components/widgets_editor.dart';

class TextEditor extends StatefulWidget {
  final Note note;

  TextEditor({Key key, this.note}) : super(key: key);

  @override
  _TextEditorState createState() => _TextEditorState(this.note);
}

class _TextEditorState extends State<TextEditor> {
  final Note note;
  final db = Firestore.instance;

  _TextEditorState(this.note);

  TextEditingController _notesController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();

  void createData() async {
    DocumentReference ref = await db
        .collection('noteData')
        .add({'note': _notesController.text, 'title': _titleController.text});
    setState(() {
      note.documentId = ref.documentID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffEAEDF4),
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(flex: 5, child: buildTitleEditor(_titleController)),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Color(0xff2C2D39),
//                        color: Color(0xff161722),
                        onPressed: (){

                          createData();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.save),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        builNoteEditor(_notesController),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}