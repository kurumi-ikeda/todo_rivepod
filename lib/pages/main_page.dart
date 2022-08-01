import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/firebase_access.dart';
import '../viewModel/todo_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAccessInstance = ref.watch(firebaseAccessProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDoアプリ"),
        actions: const [
          ToDoCreate(),
        ],
      ),
      body: firebaseAccessInstance.when(
        error: (e, stackTrace) {
          return Text(e.toString());
        },
        data: (data) {
          final list = data.docs.map<String>((DocumentSnapshot document) {
            final documentData = document.data()! as Map<String, dynamic>;
            // print(documentData);
            print(documentData['isDone'] as bool);
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
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );

    // `ref` を使ってプロバイダーを監視する
    // final counter = ref.watch(counterProvider);
  }
}
