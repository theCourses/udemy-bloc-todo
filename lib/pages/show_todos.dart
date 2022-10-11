import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/blocs.dart';
import 'package:todo_app/blocs/filtered_todos/filtered_todos_bloc.dart';
import 'package:todo_app/models/models.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
          context.read<FilteredTodosBloc>().add(SetFilteredTodosEvent(
              filter: context.read<TodoFilterBloc>().state.filter,
              todoList: state.todoList,
              searchTerm: context.read<TodoSearchBloc>().state.searchTerm));
        }),
        BlocListener<TodoFilterBloc, TodoFilterState>(
            listener: (context, state) {
          context.read<FilteredTodosBloc>().add(SetFilteredTodosEvent(
              filter: state.filter,
              todoList: context.read<TodoListBloc>().state.todoList,
              searchTerm: context.read<TodoSearchBloc>().state.searchTerm));
        }),
        BlocListener<TodoSearchBloc, TodoSearchState>(
            listener: (context, state) {
          context.read<FilteredTodosBloc>().add(SetFilteredTodosEvent(
              filter: context.read<TodoFilterBloc>().state.filter,
              todoList: context.read<TodoListBloc>().state.todoList,
              searchTerm: state.searchTerm));
        })
      ],
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                background: showBackgrount(0),
                onDismissed: (_) {
                  context
                      .read<TodoListBloc>()
                      .add(RemoveTodoEvent(removeTodo: todos[index]));
                },
                confirmDismiss: (_) {
                  return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Do you really want to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('no')),
                          ],
                        );
                      });
                },
                secondaryBackground: showBackgrount(1),
                key: ValueKey(todos[index].id),
                child: _TodoItem(todo: todos[index]));
          },
          separatorBuilder: (BuildContext context, int idx) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: todos.length),
    );
  }

  Widget showBackgrount(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class _TodoItem extends StatefulWidget {
  final Todo todo;
  const _TodoItem({required this.todo});

  @override
  State<_TodoItem> createState() => __TodoItemState();
}

class __TodoItemState extends State<_TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool error = false;
              textEditingController.text = widget.todo.desc;

              return StatefulBuilder(builder: (BuildContext build, setState) {
                return AlertDialog(
                  title: const Text('Edit dialog'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: error ? "Value cannot be empty" : null),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            error = textEditingController.text.isEmpty;
                            if (!error) {
                              context.read<TodoListBloc>().add(EditTodoEvent(
                                  id: widget.todo.id,
                                  todoDesc: textEditingController.text));
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: const Text('Confirm')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'))
                  ],
                );
              });
            });
      },
      title: Text(widget.todo.desc),
      leading: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(
                id: widget.todo.id,
              ));
        },
      ),
    );
  }
}
