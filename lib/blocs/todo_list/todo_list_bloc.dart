// ignore_for_file: depend_on_referenced_packages, unrelated_type_equality_checks

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/models.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    emit(state.copyWith(todoList: [...state.todoList, Todo(desc: event.todoDesc)]));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todoList.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: todo.id, desc: event.todoDesc, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todoList.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: todo.id, desc: todo.desc, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todoList.where((Todo element) => element.id != event.removeTodo.id).toList();
    emit(state.copyWith(todoList: newTodos));
  }
}
