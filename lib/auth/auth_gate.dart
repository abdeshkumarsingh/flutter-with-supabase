import 'package:crud/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../screens/auth_screens/login_screen.dart';

 class AuthGate extends StatelessWidget {
   const AuthGate({super.key});

   @override
   Widget build(BuildContext context) {
     return StreamBuilder(stream: Supabase.instance.client.auth.onAuthStateChange,
         builder: (context, snapshot) {
        //If session is not active and not valid
       if(snapshot.connectionState == ConnectionState.waiting) {
         return const Scaffold(
           body: Center(
             child: CircularProgressIndicator(),
           ),
         );
       }

       //If the session is active and valid
         final session = snapshot.hasData ? snapshot.data!.session : null;

       if(session != null) {
         return HomeScreen();
       } else {
         return LoginScreen();
       }

       }
     );
   }
 }
