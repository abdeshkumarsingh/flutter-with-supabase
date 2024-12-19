import 'package:crud/services/provider/auth_provider.dart';
import 'package:crud/utils/images.dart';
import 'package:crud/widgets/auth_textfield/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 70, top: 70, left: 80, right: 80),
                child: Image.asset(ImagesAssets.kLockPng),
              ),
              AuthTextfield(
                hintText: 'Enter your email',
                prefixIcon: Icons.mail,
                controller: _emailController,
                obscuretext: false,
              ),
              const SizedBox(height: 30,),
              Consumer<AuthProvider>(builder: (context, value, child) => AuthTextfield(
                hintText: 'Enter your Password',
                prefixIcon: Icons.key,
                controller: _passwordController,
                obscuretext: value.isObfuscated,
                suffix: InkWell(
                  child: value.isObfuscated ? Icon(Icons.add_moderator) : Icon(Icons.remove_moderator),
                  onTap: (){
                        value.hidePassword();
                  },
                ),
              ),),
              const SizedBox(height: 20,),
              Consumer<AuthProvider>(builder: (context, value, child) => TextButton(
                onPressed: () async {
                  bool user = await value.logIn(_emailController.text, _passwordController.text);
                  if(user){
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.errorMessage!)));
                    value.clearError();
                  }
                },
                child: value.isLoading ? CircularProgressIndicator() : Text('Login', style: TextStyle(color: Colors.white),),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                ),
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  GestureDetector(
                    child: Text('Sign Up here.', style: TextStyle(color: Colors.blue),),
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                  )
                ],
              ),
              GestureDetector(
                child: const Text('Forget Password?', style: TextStyle(color: Colors.blue),),
                onTap: (){
                  Navigator.pushNamed(context, '/resetPassword');
                },
              )
            ],
          ),
        )
      ),
    );
  }
}
