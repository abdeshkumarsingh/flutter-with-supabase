import 'package:crud/auth/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
  final AuthServices _authServices = AuthServices();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;


Future<bool> logIn(String email, String password) async{
   _isLoading = true;
   _errorMessage = null;
   notifyListeners();

   try{
     await _authServices.signInWithEmail(email, password);
     _isLoading = false;
     notifyListeners();
     return true;
   } catch (error) {
     _isLoading = false;
     _errorMessage = error.toString();
     notifyListeners();
     return false;
   }
}

void clearError(){
  _errorMessage = null;
  notifyListeners();
}
}