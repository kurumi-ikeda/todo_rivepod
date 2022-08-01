import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAccessProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      //コレクションの指定
      .collection("ToDo")
      //どの順番にするか
      .orderBy("creationTime")
      .snapshots();
});
