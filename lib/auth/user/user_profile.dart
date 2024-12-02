import 'package:crud/services/Models/profile_model.dart';
import 'package:crud/services/Models/user_data_model.dart';
import 'package:crud/services/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfile {

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> createUser(UserModel user) async {
  }

  Future<void> createProfileDetails(ProfileModel profile) async {
    final response = await _supabase.from('profiles').insert(profile.toMap());
  }

  Future<void> createUserData(UserDataModel userdata) async{
    final response = await _supabase.from('user_data').insert(userdata.toMap());
  }

  // Fetch User Profile by UserID
  Future<UserModel?> fetchUserProfile(String userId) async {
    final response = await _supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();

      return UserModel.fromMap(response);
  }

  Future<ProfileModel?> fetchProfileDetails(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

      return ProfileModel.fromMap(response);
  }

  // Fetch User Data by UserID
  Future<List<UserDataModel>> fetchUserData(String userId) async {
    final response = await _supabase
        .from('user_data')
        .select()
        .eq('user_id', userId);


    return (response as List<dynamic>)
        .map((item) => UserDataModel.fromMap(item))
        .toList();
  }

  // Update User Profile
  Future<void> updateUserProfile(String userId, String? fullName, String? avatarUrl) async {
    final response = await _supabase.from('users').update({
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  Future<void> updateProfileDetails(String userId, String? bio, String? phoneNumber) async {
    final response = await _supabase.from('profiles').update({
      'bio': bio,
      'phone_number': phoneNumber,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  // Update User Data
  Future<void> updateUserData(String userId, String dataId, String title, String? content) async {
    final response = await _supabase.from('user_data').update({
      'title': title,
      'content': content,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', dataId).eq('user_id', userId);
    }


  }