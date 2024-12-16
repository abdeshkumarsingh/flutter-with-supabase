import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/Note/note.dart';
import '../Models/note_model.dart';

class NoteProvider with ChangeNotifier{

  final _table = Supabase.instance.client.from('crudapp');
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final _supabase = Supabase.instance.client;
  final _note = Note();
  String? _errorMessage;

  String? get errorMessage => _errorMessage;



  void addNote(String content, String note_name){
    _errorMessage = null;
    try{
      final newNote = NoteModel(content: content, note_name: note_name, user_id: userId);
      _note.createNote(newNote);
    } on Exception catch(error){
      _errorMessage = error.toString();
      throw Exception(error.toString());
    }
    notifyListeners();
  }

  void updateNote(String content, int id){
    _note.updateNote(id, content);
    notifyListeners();
  }

  void deleteNote(int id){
    _note.deleteNote(id);
    notifyListeners();
  }

}