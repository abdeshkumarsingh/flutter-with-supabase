import '../../services/Models/note_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth_services.dart';

class Note {
  final database = Supabase.instance.client.from('crudapp');

  //create
Future createNote(NoteModel newNote) async{
  await database.insert(newNote.toJson());
}

//read
  final stream = Supabase.instance.client.from('crudapp').
  stream(primaryKey: ['id']).map((data) => data.map((noteMap) => NoteModel.fromJson(noteMap)).toList());

//update
Future updateNote(int id, String newContent) async{
  await database.update({'content' : newContent}).eq('id', id);
}

//delete
Future deleteNote(int id) async{
  await database.delete().eq('id', id);
}
}