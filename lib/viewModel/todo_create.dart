import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/firebase_access.dart';
import '../model/todo.dart';

class ToDoCreate extends ConsumerStatefulWidget {
  const ToDoCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ToDoCreateState();
}

class _ToDoCreateState extends ConsumerState<ToDoCreate> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final inputText = await showDialog<String>(
            context: context,
            builder: (context) {
              return const _ToDoCreateDialog();
            },
          );
          if (inputText == null || inputText.isEmpty) {
            return;
          }
          final ToDo finishedToDo = ToDo.create(text: inputText);
          //firestoreに登録
          FirebaseAccess().addToDoFirestore(finishedToDo);
        },
        icon: const Icon(Icons.add));
  }
}

class _ToDoCreateDialog extends StatefulWidget {
  const _ToDoCreateDialog({Key? key}) : super(key: key);

  @override
  State<_ToDoCreateDialog> createState() => __ToDoCreateDialogState();
}

class __ToDoCreateDialogState extends State<_ToDoCreateDialog> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('タスクを記録'),
      content: TextFormField(
        controller: controller,
        enabled: true,
        maxLength: 15,
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
            child: const Text("保存"),
            onPressed: () {
              final text = controller.text;
              Navigator.of(context).pop(text);
            })
      ],
    );
  }
}
