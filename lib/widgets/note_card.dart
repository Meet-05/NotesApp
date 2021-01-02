import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/add_task_sheet.dart';

const double ContainerWidth = 380;

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final Timestamp id;

  User user = FirebaseAuth.instance.currentUser;
  NoteCard({this.title, this.content, this.id});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.only(top: 30.0, left: 2.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 50.0,
        ),
        alignment: Alignment.centerRight,
      ),
      onDismissed: (direction) {
        print('wola');
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .doc(id.toString())
            .delete();
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to permanantely delete this?'),
                  actions: [
                    FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        }),
                    FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        }),
                  ],
                ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0, left: 10.0),
            padding: EdgeInsets.all(20.0),
            width: ContainerWidth,
            decoration: BoxDecoration(
              color: Color(0xFFffe6e6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: GestureDetector(
                onTap: () {
                  showModalBottomSheet<dynamic>(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(),
                      context: context,
                      builder: (context) => AddTaskSheet(
                          title: title,
                          content: content,
                          id: id.toString(),
                          existed: true));
                },
                child: ListTile(
                  title: Text(
                    title,
                    style: ktitleStyle,
                  ),
                  trailing: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      id.toDate().day.toString() +
                          '/' +
                          id.toDate().month.toString() +
                          '/' +
                          id.toDate().year.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(left: 10.0),
            width: ContainerWidth,
            decoration: BoxDecoration(
              color: Color(0xFFffabe1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(content),
            ),
          )
        ],
      ),
    );
  }
}
