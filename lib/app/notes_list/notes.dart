import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutternotes/app/shared/size_config.dart';
import 'package:flutternotes/app/text_editor/text_editor.dart';
import 'file:///C:/Users/joaog/OneDrive/Desenvolvimento/flutter_psychology/lib/app/shared/model/notes_model.dart';
import 'package:flutternotes/app/text_editor/update_editor.dart';

class Notes extends StatefulWidget {
  Notes({Key key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final Note note = Note();
  final db = Firestore.instance;
  String id;

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('noteData').document(doc.documentID).delete();
    setState(() {
      id = null;
    });
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateEditor(
                  noteData: ds,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            color: Color(0xff2C2D39),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TextEditor()));
            },
            icon: Icon(Icons.add),
          )
        ],
        textTheme: TextTheme(
            title: TextStyle(
                color: Color(0xff2C2D39),
                fontSize: SizeConfig.widthMultiplier * 7)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Suas Notas'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance.collection('noteData').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                '"Carregando Notas..."',
                style: TextStyle(fontSize: 24, color: Color(0xff2C2D39)),
              ));
            }
            int length = snapshot.data.documents.length;
            return ListView.builder(
              itemCount: length,
              padding: EdgeInsets.all(2),
              itemBuilder: (_, int index) {
                final DocumentSnapshot doc = snapshot.data.documents[index];

                return InkWell(
                  onTap: () {
                    navigateToDetail(doc);
                  },
                  child: Card(
                      child: ListTile(
                    title: Text(
                      doc.data['title'],
                      style: TextStyle(),
                    ),
                    subtitle: Text(
                      doc.data['note'],
                      style: TextStyle(),
                    ),
                    trailing: Wrap(
                      children: <Widget>[
                        InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onTap: () {
                            return showDialog<bool>(
                              context: context,
                              barrierDismissible: false,
                              // dialog is dismissible with a tap on the barrier
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  title: Text('Deseja excluir essa nota?'),
                                  content: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'Não será possível recuperar os dados mais tarde'),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Não excluir'),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Excluir',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        deleteData(doc);
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
