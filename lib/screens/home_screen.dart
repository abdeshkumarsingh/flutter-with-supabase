import 'package:crud/screens/other_screens/user_profile_screen.dart';
import 'package:crud/services/Models/user_model.dart';
import 'package:crud/auth/Note/note.dart';
import 'package:crud/services/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/provider/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final database_connection = Note();
  final noteController = TextEditingController();
  final readNoteController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<NoteProvider>(builder: (context, value, child) => FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Note'),
                content: TextField(
                  controller: noteController,
                ),
              actions: [
                //cancel button
                TextButton(onPressed: (){
                  Navigator.pop(context);
                  noteController.clear();
                }, child: Text('Cancel')),

                //Create note Button
                TextButton(onPressed: (){
                  if(value.errorMessage != null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.errorMessage!)));
                    return;
                  }
                  value.addNote('write something here', noteController.text);
                  Navigator.pop(context);
                  noteController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note Created')));
                }, child: Text('Create')),
              ],
            )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: false,
        backgroundColor: Colors.orange,
        actions: [
          Consumer<UserProfileProvider>(builder: (context, value, child) => InkWell(
            onTap: () async {
              UserModel userDetails = await value.fetchUser();
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(user: userDetails),));
            },
            child: Icon(Icons.person),
          ),),
        ],),
      body: Consumer<NoteProvider>(builder: (context, value, child) {
        return StreamBuilder(stream: database_connection.stream, builder: (context, snapshot) {
          //no data in snapshot
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //Snapshot has data
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Column(
                children: [
                  ListTile(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Read Note'),
                          content: Card(
                            child: Text(note.content),
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              readNoteController.clear();
                            }, child: Text('Back')),
                          ],
                        ),
                      );
                    },
                    tileColor: Colors.red,
                    title: Text(note.note_name),
                    leading: Icon(Icons.note_outlined),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Update Note'),
                              content: TextField(
                                controller: readNoteController,
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  readNoteController.clear();
                                }, child: Text('Back')),
                                TextButton(onPressed: (){
                                  if(value.errorMessage != null){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.errorMessage!)));
                                    return;
                                  }
                                  value.updateNote(readNoteController.text, note.id!);
                                  Navigator.pop(context);
                                  readNoteController.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note Updated')));
                                }, child: Text('Update')),
                              ],
                            ),
                          );
                        }, icon: Icon(Icons.edit)),
                        IconButton(onPressed: (){value.deleteNote(note.id!);}, icon: Icon(Icons.delete))
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
      }),
    );
  }
}
