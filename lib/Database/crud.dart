import 'package:flutter/cupertino.dart';

class Crud{
  int? id;
  String note_name;
  String content;

  Crud({this.id, required this.content, required this.note_name});

  factory Crud.fromMap(Map<String, dynamic> map) {
       return Crud(
         id: map['id'] as int,
           content: map['content'] as String,
           note_name: map['note_name'] as String);
  }

  Map<String, dynamic> toMap(){
    return {
      'content' : content,
      'note_name' : note_name,
    };
  }
}
