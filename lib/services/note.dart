import 'package:flutter/cupertino.dart';

class Note{
  int? id;
  String note_name;
  String content;

  Note({this.id, required this.content, required this.note_name});
//fromjson
  factory Note.fromJson(Map<String, dynamic> map) {
       return Note(
         id: map['id'] as int,
           content: map['content'] as String,
           note_name: map['note_name'] as String);
  }
//tojson
  Map<String, dynamic> toJson(){
    return {
      'content' : content,
      'note_name' : note_name,
    };
  }
}
