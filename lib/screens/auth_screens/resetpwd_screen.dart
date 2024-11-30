import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/auth_provider.dart';
import '../../utils/images.dart';
import '../../widgets/auth_textfield/auth_textfield.dart';

class ResetpwdScreen extends StatefulWidget {
  const ResetpwdScreen({super.key});

  @override
  State<ResetpwdScreen> createState() => _ResetpwdScreenState();
}

class _ResetpwdScreenState extends State<ResetpwdScreen> {

  final _emailController = TextEditingController();

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
                  padding: const EdgeInsets.only(bottom: 70, top: 70, left: 80, right: 80),
                  child: Image.asset(ImagesAssets.kResetPass),
                ),
                AuthTextfield(
                  hintText: 'Enter your email',
                  prefixIcon: Icons.mail,
                  controller: _emailController,
                  obscuretext: false,
                ),
                const SizedBox(height: 30,),
                Consumer<AuthProvider>(builder: (context, value, child) => TextButton(
                  onPressed: () async {
                    bool user = await value.resetPassword(_emailController.text);
                    if(user){
                      Navigator.pushReplacementNamed(context, '/signin');
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.errorMessage!)));
                      value.clearError();
                    }
                  },
                  child: value.isLoading ? CircularProgressIndicator() : Text('Reset', style: TextStyle(color: Colors.white),),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
                  ),
                ),
                ),
                GestureDetector(
                  child: const Text('Go Back', style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.pushNamed(context, '/login');
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}
