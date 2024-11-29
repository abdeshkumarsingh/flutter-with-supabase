import 'package:crud/Database/crud.dart';
import 'package:crud/Database/database_connection.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final database_connection = Database_connection();
  final noteController = TextEditingController();
  final readNoteController = TextEditingController();

  //create note
  void createNote() {
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
            final newNote = Crud(content: 'Write Something Here', note_name: noteController.text);
            database_connection.createNote(newNote);
            Navigator.pop(context);
            noteController.clear();
          }, child: Text('Create'))
        ],
     )
    );
  }

  //read note
  void readNote(String content){
    readNoteController.text = content;
    showDialog(context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: readNoteController,
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            readNoteController.clear();
          }, child: Text('Back')),
        ],
      ),
    );
  }

  //update note
  void updateNote(Crud content) {
    readNoteController.text = content.content;
    showDialog(context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: readNoteController,
          
        ),
        actions: [
          TextButton(onPressed: (){
            database_connection.updateNote(content, readNoteController.text);
            Navigator.pop(context);
            readNoteController.clear();
          }, child: Text('Update')),
        ],
      ),
    );
  }

  //delete note
  void deleteNote(Crud note) {
    database_connection.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){createNote();}, child: Icon(Icons.add), backgroundColor: Colors.red,),
      appBar: AppBar(title: Text('CRUD APP'), centerTitle: true, backgroundColor: Colors.orange,),
      body: StreamBuilder(stream: database_connection.stream, builder: (context, snapshot) {
        //no data in snapshot
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //Snapshot has data
        final notes = snapshot.data!;

        //Return list of data
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];

            return Column(
              children: [
                ListTile(
                  onTap: (){readNote(note.content);},
                  tileColor: Colors.red,
                  title: Text(note.note_name),
                  leading: Icon(Icons.note_outlined),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){updateNote(note);}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){deleteNote(note);}, icon: Icon(Icons.delete))
                    ],
                  ),
                )
              ],
            );
          },
        );
      },),
    );
  }
}