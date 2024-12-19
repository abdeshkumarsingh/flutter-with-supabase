import 'dart:io';

import 'package:crud/services/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth_services.dart';

class UserProfile {

  final SupabaseClient _supabase = Supabase.instance.client;
  final _authServices = AuthServices();

  Future<UserModel> fetchProfile() async {
    try{
      final response = await _supabase.from('users').select()
        .eq('id', _supabase.auth.currentUser!.id).single();
      return UserModel.fromJson(response);
    } on PostgrestException catch (error){
      throw Exception(error.message);
    }
  }

  Future<void> updateProfile(UserModel user) async{
    if(_authServices.getUserId()!.isEmpty){
      throw Exception('No User Logged in.');
    }
    try{
      await _supabase.from('users').update(user.toJson()).eq('id', _authServices.getUserId() as Object);
    } on PostgrestException catch(error){
      throw Exception(error.message);
    }
  }

  Future<bool> updateAvatar(File file) async{
    try{
      final fileName = file.path.split('/').last;
      final upload = await _supabase.storage.from('profile-images').upload('public/${_authServices.getUserId()}/$fileName', file);
      return true;
    } on PostgrestException catch(error){
      throw Exception(error.message);
    }
  }

  // Future<void> deleteAvatar() async{
  //   try{
  //     await _supabase.storage.from('profile-images').delete('public/$userId/');
  //   } on PostgrestException catch(error){
  //     throw Exception(error.message);
  //   }
  // }

}
