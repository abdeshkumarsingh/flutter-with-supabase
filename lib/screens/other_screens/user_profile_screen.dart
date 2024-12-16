import 'dart:io';

import 'package:crud/services/Models/user_model.dart';
import 'package:crud/services/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  UserModel user;
  UserProfileScreen({super.key, required this.user });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            child: const Icon(Icons.arrow_back_ios),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.logout),
          ),
        ]
      ),
      body: Center(
        child: Consumer<UserProfileProvider>(builder: (context, value, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Profile image
            Consumer<UserProfileProvider>(builder: (context, value, child) => GestureDetector(
              onTap: () async{
                if(value.isEnabled == true){
                  final path = await value.pickImage();
                  await value.profileImageUpload(path!);
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.avatarUrl),
                radius: 80,
              ),
            ),
            ),
            Consumer<UserProfileProvider>(builder: (context, value, child) => TextField(
              controller: _nameController,
              // enabled: false,
              readOnly: !value.isEnabled,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  hintText: 'Name : ${widget.user.fullName}'
              ),
              onTap: (){
              },
            ),
            ),
            TextField(
              // enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red)
                  ),
                  hintText: 'Email : ${widget.user.email}'
              ),
            ),
            Consumer<UserProfileProvider>(builder: (context, value, child) => TextButton(
                onPressed: () async{
                  String name;
                  final imageUrl;
                   if(value.isEnabled == true){
                    if(_nameController.text.isEmpty){
                      name = widget.user.fullName;
                    } else {
                      name = _nameController.text;
                    }

                   if(value.imagePath != null) {
                     imageUrl = await value.imageLinkUpdate();
                   } else {
                     imageUrl = widget.user.avatarUrl;
                   }
                     value.updateUser(UserModel(id: widget.user.id, email: widget.user.email, fullName: name, avatarUrl: imageUrl, createdAt: DateTime.now()));
                     _nameController.clear();
                     value.setIsEnabled(false);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated')));
                     Navigator.pop(context);
                   } else {
                     value.setIsEnabled(true);
                   }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: value.isEnabled ?  value.isLoading ? const CircularProgressIndicator() : const Text('Update') : const Text('Edit')
              ),
            )
          ],
        ),
        )
      ),
    );
  }
}
