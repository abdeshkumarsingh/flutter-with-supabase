import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {

  //initialization of supabase client
  final SupabaseClient _supabase = Supabase.instance.client;

  //Signin with email
Future<AuthResponse> signInWithEmail(String email, String password) async{
return await _supabase.auth.signInWithPassword(
    email: email,
    password: password
);
}

  //Signup with email
Future<AuthResponse> signUpWithEmail(String email, String password) async{
  return await _supabase.auth.signUp(
      email: email,
      password: password
  );
}

  //Reset password
Future<void> resetPassword(String email) async{
  await _supabase.auth.resetPasswordForEmail(email);
}

  //Signout
Future<void> signOut() async{
  await _supabase.auth.signOut();
}

  //Fetch current user email
String? getCurrentUserEmail() {
  final session = _supabase.auth.currentSession;
  final user = session?.user;
  return user?.email;
}


}