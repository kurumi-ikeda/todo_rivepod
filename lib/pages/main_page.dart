import 'package:flutter/material.dart';

import '../viewModel/todo_create.dart';
import '../viewModel/todo_list_view.dart';

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
      body: const ToDoListView(),
    );
  }
}
