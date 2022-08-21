import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/todo.dart';

class ToDoListView extends ConsumerWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ToDo> toDos = ref.watch(toDosProvider);

    return ListView(
      children: [
        for (final toDo in toDos)
          CheckboxListTile(
            secondary: IconButton(
              onPressed: () {
                ref.read(toDosProvider.notifier).removeTodo(toDo.id);
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(toDo.text),
            subtitle: Text(
                "${toDo.creationTime.year}年${toDo.creationTime.month}月${toDo.creationTime.day}日${toDo.creationTime.hour}時${toDo.creationTime.minute}分"),
            value: toDo.isDone,
            onChanged: (value) =>
                ref.read(toDosProvider.notifier).isDoneChange(toDo.id),
          )
      ],
    );
  }
}
