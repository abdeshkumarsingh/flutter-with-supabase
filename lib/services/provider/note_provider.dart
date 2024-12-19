import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/Note/note.dart';
import '../../auth/auth_services.dart';
import '../Models/note_model.dart';

class NoteProvider with ChangeNotifier{

  AuthServices _authServices = AuthServices();
  final _note = Note();
  String? _errorMessage;

  String? get errorMessage => _errorMessage;



  void addNote(String content, String note_name){
    _errorMessage = null;
    try{
      final userId = _authServices.getUserId();
      final newNote = NoteModel(content: content, note_name: note_name, user_id: userId as String);
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