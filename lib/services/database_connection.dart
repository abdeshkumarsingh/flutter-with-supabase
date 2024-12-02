import 'Models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database_connection {
  final database = Supabase.instance.client.from('crudapp');

  //create
Future createNote(Note newNote) async{
  await database.insert(newNote.toJson());
}

//read
final stream = Supabase.instance.client.from('crudapp').stream(primaryKey: ['id']).map((data) => data.map((noteMap) => Note.fromJson(noteMap)).toList());

//update
Future updateNote(Note oldNote, String newContent) async{
  await database.update({'content' : newContent}).eq('id', oldNote.id!);
}

//delete
Future deleteNote(Note note) async{
  await database.delete().eq('id', note.id!);
}
}