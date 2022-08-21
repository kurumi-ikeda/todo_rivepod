import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

@immutable
class ToDo {
  const ToDo(
      {required this.text,
      required this.creationTime,
      required this.id,
      required this.isDone});

  ToDo.create({required this.text})
      : creationTime = DateTime.now(),
        id = const Uuid().v4(),
        isDone = false;

  //本文
  final String text;
  //作成をした時間
  final DateTime creationTime;
  //uuidを使って匿名出来るようにする
  final String id;
  //ToDoの内容を達成したか
  final bool isDone;

  ToDo copyWith(
      {String? text, DateTime? creationTime, String? id, bool? isDone}) {
    return ToDo(
        text: text ?? this.text,
        creationTime: creationTime ?? this.creationTime,
        id: id ?? this.id,
        isDone: isDone ?? this.isDone);
  }
}

class _ToDosNotifier extends StateNotifier<List<ToDo>> {
  _ToDosNotifier() : super([]);

  void addTodo(ToDo toDo) {
    state = [...state, toDo];
    // print(state);
  }

  void removeTodo(String toDoId) {
    // やってる事がわからなくなったときに見る
    // https://zenn.dev/iwaku/articles/2020-12-23-iwaku
    state = [
      for (final todo in state)
        if (todo.id != toDoId) todo,
    ];
  }

  void isDoneChange(String todoId) {
    state = [
      for (final toDo in state)
        if (toDo.id == todoId)
          //新しいインスタンスを返す
          toDo.copyWith(isDone: !toDo.isDone)
        else
          toDo,
    ];
  }
}

final toDosProvider = StateNotifierProvider<_ToDosNotifier, List<ToDo>>((ref) {
  return _ToDosNotifier();
});
