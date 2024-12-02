import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/auth_provider.dart';
import '../../utils/images.dart';
import '../../widgets/auth_textfield/auth_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

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
                  child: Image.asset(ImagesAssets.kSignUpPng),
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
                    bool user = await value.signUp(_emailController.text, _passwordController.text);
                    if(user){
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.errorMessage!)));
                      value.clearError();
                    }
                  },
                  child: value.isLoading ? CircularProgressIndicator() : Text('Sign Up', style: TextStyle(color: Colors.white),),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    GestureDetector(
                      child: Text('Login here.', style: TextStyle(color: Colors.blue),),
                      onTap: (){
                        Navigator.pushNamed(context, '/login');
                      },
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}

