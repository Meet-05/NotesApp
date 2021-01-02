import 'package:flutter/material.dart';
import '../widgets/notesList.dart';
import 'package:provider/provider.dart';
import '../provider/google_signin_provider.dart';
import '../widgets/add_task_sheet.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
            },
          )
        ],
      ),
      body: NotesList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
          onPressed: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(),
                context: context,
                builder: (context) => AddTaskSheet(
                      existed: false,
                    ));
          }),
    );
  }
}
