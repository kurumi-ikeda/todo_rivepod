import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/model/firebase_access.dart';
import 'package:todo_riverpod/viewModel/todo_list_view.dart';

import '../model/todo.dart';
import '../viewModel/todo_create.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ToDo> toDos = ref.watch(toDosProvider);
    final firebaseAccessInstance = ref.watch(firebaseAccessProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDoアプリ"),
        actions: const [
          ToDoCreate(),
        ],
      ),
      // body: const ToDoListView(),
      body: firebaseAccessInstance.when(
        error: (e, stackTrace) {
          return Text(e.toString());
        },
        data: (data) {
          final List<ToDo> toDoList =
              data.docs.map((DocumentSnapshot document) {
            final documentData = document.data()! as Map<String, dynamic>;
            String documentId = document.id;

            //firestoreから手に入れたデータをToDoクラスに変換
            return ToDo(
                text: documentData['text']! as String,
                creationTime: documentData['creationTime'].toDate(),
                id: documentId,
                isDone: documentData['isDone'] as bool);
          }).toList();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            for (final ToDo toDo in toDoList) {
              if (toDos.map((e) => e.id).contains(toDo.id)) {
                continue;
              }
              ref.read(toDosProvider.notifier).addTodo(toDo);
            }
          });
          return const ToDoListView();
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
