// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final String todoDesc;
  const AddTodoEvent({
    required this.todoDesc,
  });

  @override
  String toString() => 'AddTodoListEvent(todoDesc: $todoDesc)';

  @override
  List<Object> get props => [todoDesc];
}

class EditTodoEvent extends TodoListEvent {
  final int id;
  final String todoDesc;

  const EditTodoEvent({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoEvent(id: $id, todoDesc: $todoDesc)';

  @override
  List<Object> get props => [id, todoDesc];
}

class ToggleTodoEvent extends TodoListEvent {
  final int id;
  final bool isCompleted;

  const ToggleTodoEvent({
    required this.id,
    required this.isCompleted,
  });

  @override
  String toString() => 'ToggleTodoEvent(id: $id, isCompleted: $isCompleted)';

  @override
  List<Object> get props => [id, isCompleted];
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo removeTodo;

  const RemoveTodoEvent({
    required this.removeTodo,
  });

  @override
  List<Object> get props => [removeTodo];

  @override
  String toString() => 'RemoveTodoEvent(removeTodo: $removeTodo)';
}
