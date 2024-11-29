import 'crud.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database_connection {
  final database = Supabase.instance.client.from('crudapp');

  //create
Future createNote(Crud newNote) async{
  await database.insert(newNote.toMap());
}

//read
final stream = Supabase.instance.client.from('crudapp').stream(primaryKey: ['id']).map((data) => data.map((noteMap) => Crud.fromMap(noteMap)).toList());

//update
Future updateNote(Crud oldNote, String newContent) async{
  await database.update({'content' : newContent}).eq('id', oldNote.id!);
}

//delete
Future deleteNote(Crud note) async{
  await database.delete().eq('id', note.id!);
}
}