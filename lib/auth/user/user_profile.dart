import 'dart:io';

import 'package:crud/services/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {

  final SupabaseClient _supabase = Supabase.instance.client;
  final String userId = Supabase.instance.client.auth.currentUser!.id;

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
    if(userId.isEmpty){
      throw Exception('No User Logged in.');
    }
    try{
      await _supabase.from('users').update(user.toJson()).eq('id', userId);
    } on PostgrestException catch(error){
      throw Exception(error.message);
    }
  }

  Future<bool> updateAvatar(File file) async{
    try{
      final fileName = file.path.split('/').last;
      final upload = await _supabase.storage.from('profile-images').upload('public/$userId/$fileName', file);
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
