import 'dart:io';

import 'package:crud/auth/user/user_profile.dart';
import 'package:crud/services/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileProvider with ChangeNotifier{

  final _userProfile = UserProfile();
  String? _errorMessage;
  bool _isLoading = false;
  bool _isEnabled = false;
  final ImagePicker _picker = ImagePicker();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  String? _imagePath;
  final SupabaseClient _supabase = Supabase.instance.client;



  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isEnabled => _isEnabled;
  String? get imagePath => _imagePath;

  void resetError(){
    _errorMessage = null;
  }

  void setIsEnabled(bool isEnabled){
    _isEnabled = isEnabled;
    notifyListeners();
  }

  Future<UserModel> fetchUser() async{
    final user = await _userProfile.fetchProfile();
    notifyListeners();
    return user;
  }

  void updateUser(UserModel user) async{
    _errorMessage = null;
    if(_isEnabled == false){
      _isEnabled = true;
      notifyListeners();
      return;
    } else {
      try{
        _isLoading = true;
        await _userProfile.updateProfile(user);
        notifyListeners();
        _isEnabled = false;
        _isLoading = false;
      } on Exception catch(error){
        _errorMessage = error.toString();
        notifyListeners();
      }
    }
  }
  Future<File?> pickImage() async{
    final image = await _picker.pickImage(source: ImageSource.gallery);
    final file = File(image!.path);
    return file;
  }

  Future<void> profileImageUpload(File file) async{
    _errorMessage = null;
    try{
      _imagePath = file.path.split('/').last;
      bool isUploaded = await _userProfile.updateAvatar(file);
      if(isUploaded == false){
        throw Exception('Upload Failed');
      }
      notifyListeners();
    } on Exception catch(error){
      _errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<String> imageLinkUpdate() async{
    if(_imagePath == null){
      throw Exception('No Image Uploaded');
    }
    final imageUrl = await _supabase.storage.from('profile-images').createSignedUrl('public/$userId/$_imagePath', 60 * 60 * 24 * 365);
    _imagePath = null;
    return imageUrl;
  }
  void logOut(){
    Supabase.instance.client.auth.signOut();
  }
}