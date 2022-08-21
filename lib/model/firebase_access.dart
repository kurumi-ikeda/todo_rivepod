import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/model/todo.dart';

final firebaseAccessProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      //コレクションの指定
      .collection("ToDo")
      //どの順番にするか
      .orderBy("creationTime")
      .snapshots();
});

class FirebaseAccess {
  addToDoFirestore(final ToDo toDo) {
    print(toDo.id);
    FirebaseFirestore.instance.collection('ToDo').doc(toDo.id).set({
      "creationTime": Timestamp.fromDate(toDo.creationTime),
      "isDone": toDo.isDone,
      "text": toDo.text
    });
  }

  deleteToDoFirestore(final ToDo toDo) {
    FirebaseFirestore.instance.collection("ToDo").doc(toDo.id).delete();
  }
}
