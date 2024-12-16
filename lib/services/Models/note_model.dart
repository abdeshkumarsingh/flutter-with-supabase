import 'package:flutter/cupertino.dart';

class NoteModel{
  int? id;
  String note_name;
  String content;
  String user_id;

  NoteModel({this.id, required this.content, required this.note_name, required this.user_id});
//fromjson
  factory NoteModel.fromJson(Map<String, dynamic> map) {
       return NoteModel(
           id: map['id'] as int,
           content: map['content'] as String,
           note_name: map['note_name'] as String,
           user_id: map['user_id'] as String);
  }
//tojson
  Map<String, dynamic> toJson(){
    return {
      'content' : content,
      'note_name' : note_name,
      'user_id' : user_id,
    };
  }
}
