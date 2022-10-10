import 'package:flutter/material.dart';
import 'package:todo_app/pages/create_todo.dart';
import 'package:todo_app/pages/todo_header.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Column(children: [TodoHeader(), CreateTodo()]),
        ),
      )),
    );
  }
}
