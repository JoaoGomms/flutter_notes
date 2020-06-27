import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternotes/app/text_editor/components/widgets_editor.dart';

class UpdateEditor extends StatefulWidget {
  final DocumentSnapshot noteData;

  UpdateEditor({Key key, this.noteData}) : super(key: key);

  @override
  _UpdateEditorState createState() => _UpdateEditorState(this.noteData);
}

class _UpdateEditorState extends State<UpdateEditor> {
  final DocumentSnapshot noteData;
  final db = Firestore.instance;

  _UpdateEditorState(this.noteData);

  TextEditingController _notesController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _notesController =
        new TextEditingController(text: widget.noteData.data['note']);
    _titleController =
        new TextEditingController(text: widget.noteData.data['title']);
  }

  void updateData() async {
    Firestore.instance
        .collection('noteData')
        .document(widget.noteData.documentID)
        .updateData(
            {'title': _titleController.text, 'note': _notesController.text});
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
                    Expanded(
                        flex: 5, child: buildTitleEditor(_titleController)),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Color(0xff2C2D39),
//                        color: Color(0xff161722),
                        onPressed: () async {
                          updateData();
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
