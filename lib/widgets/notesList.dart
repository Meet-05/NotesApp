import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/note_card.dart';

class NotesList extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            // .collection('users/' + user.uid + '/notes/')
            .collection('users')
            .doc(user.uid)
            .collection('notes')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final notes = snapshot.data.docs;

          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => NoteCard(
                    title: notes[index]['title'],
                    content: notes[index]['content'],
                    id: notes[index]['createdAt'],
                  ));
        });
  }
}
