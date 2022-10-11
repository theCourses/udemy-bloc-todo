// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/blocs.dart';
import 'package:todo_app/blocs/filtered_todos/filtered_todos_bloc.dart';
import 'package:todo_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:todo_app/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<ActiveTodoCountBloc>(
          create: (context) => ActiveTodoCountBloc(
            initialActiveTodoCount:
                context.read<TodoListBloc>().state.todoList.length,
          ),
        ),
        BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
                  initialTodos: context.read<TodoListBloc>().state.todoList,
                ))
      ],
      child: MaterialApp(
          title: 'Todo app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TodoPage()),
    );
  }
}
