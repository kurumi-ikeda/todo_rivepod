import 'package:flutter/material.dart';

import '../viewModel/todo_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ToDoアプリ"),
          actions: const [
            ToDoCreate(),
          ],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("ToDo")
                .orderBy("creationTime")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('エラーが発生しました');
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final list = snapshot.requireData.docs
                  .map<String>((DocumentSnapshot document) {
                final documentData = document.data()! as Map<String, dynamic>;
                return documentData['text']! as String;
              }).toList();

              final reverseList = list.reversed.toList();

              return ListView.builder(
                  itemCount: reverseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Text(
                      reverseList[index],
                      style: const TextStyle(fontSize: 20),
                    ));
                  });
            },
          ),
        )
        // body: const ToDoListView(),
        );
  }
}
