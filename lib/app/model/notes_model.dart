import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String _title;
  String _note;
  String _documentId;

  Note({String title, String note}) {
    this._title = title;
    this._note = note;
  }

  String get title => _title;
  set title(String title) => _title = title;

  String get documentId => _documentId;
  set documentId(String documentId) => _documentId = documentId;

  String get note => _note;
  set note(String note) => _note = note;

  Note.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _note = json['note'];
    _documentId = json['documentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['note'] = this._note;
    data['documentId'] = this._documentId;
    return data;
  }

  Note.fromSnapshot(DocumentSnapshot snapshot) :
        _title = snapshot['title'],
        _documentId = snapshot.documentID,
        _note = snapshot['note'];
}

