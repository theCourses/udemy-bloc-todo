import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/models.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newsTodos = [...state.todoList, newTodo];
    emit(state.copyWith(todoList: newsTodos));
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = state.todoList.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todoDesc, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.todoList.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todo.desc, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodos));
  }

  void removeTodo(Todo todo) {
    final newTodos =
        state.todoList.where((Todo todo) => todo.id != todo.id).toList();
    emit(state.copyWith(todoList: newTodos));
  }
}
