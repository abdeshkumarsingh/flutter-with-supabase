import 'package:crud/auth/auth_gate.dart';
import 'package:crud/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bdrnbpzrdmvhfeniuzrn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJkcm5icHpyZG12aGZlbml1enJuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI2OTI0NjIsImV4cCI6MjA0ODI2ODQ2Mn0.icU1jKnl7OAqKr00PUzkpU1NT0_wQbfdKnGsTMKiU9I',
  );
  runApp(const Crudapp());
}
final supabase = Supabase.instance.client;

class Crudapp extends StatelessWidget {
  const Crudapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/home' : (context) => const HomeScreen(),
      },
    );
  }
}


