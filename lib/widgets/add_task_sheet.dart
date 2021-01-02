import 'package:flutter/material.dart';
import 'package:NotesApp/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTaskSheet extends StatefulWidget {
  String title;
  String content;
  String id;
  bool existed;
  AddTaskSheet({this.title, this.content, this.id, this.existed});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var _form = GlobalKey<FormState>();

  String title = '';
  String content = '';
  String id = '';
  User user = FirebaseAuth.instance.currentUser;

  void submitNote() {
    var timeStamp = Timestamp.now();
    String StringtimeStamp = timeStamp.toString();

    if (_form.currentState.validate()) {
      _form.currentState.save();
      if (widget.existed) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .doc(widget.id)
            .update({
          // 'createdAt': timeStamp,
          'content': content,
          'title': title,
        });
      } else {
        print('$title $content');

        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .doc(StringtimeStamp)
            .set({
          'createdAt': timeStamp,
          'content': content,
          'title': title,
        });
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: widget.existed ? widget.title : title,
                style: ktitleStyle.copyWith(),
                // controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 20.0),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: widget.existed ? widget.content : content,
                // controller: contentController,
                style: ktitleStyle.copyWith(fontSize: 20.0),
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Content',
                  labelStyle: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 20.0),
                ),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Content is empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  content = value;
                },
                onEditingComplete: () {
                  submitNote();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
