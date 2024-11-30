import 'package:crud/utils/images.dart';
import 'package:crud/widgets/auth_textfield/auth_textfield.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 50, top: 50, left: 80, right: 80),
              child: Image.asset(ImagesAssets.kLockPng),
            ),
            AuthTextfield(
              hintText: 'Enter your email',
              prefixIcon: Icons.mail,
              controller: _emailController,
            ),
            SizedBox(height: 30,),
            AuthTextfield(
              hintText: 'Enter your Password',
              prefixIcon: Icons.mail,
              controller: _passwordController,
              suffix: InkWell(
                child: const Icon(Icons.remove_red_eye),
                onTap: (){

                },
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: (){},
                child: Text('Login', style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
