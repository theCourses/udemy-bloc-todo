// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/models.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;

  FilteredTodosCubit({
    required this.initialTodos,
  }) : super(FilteredTodosState(filteredTodos: initialTodos));

  void setFilteredTodos(Filter filter, List<Todo> todoList, String searchTerm) {
    List<Todo> filteredTodos;
    switch (filter) {
      case Filter.active:
        filteredTodos =
            todoList.where((element) => !element.isCompleted).toList();
        break;
      case Filter.completed:
        filteredTodos =
            todoList.where((element) => element.isCompleted).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoList;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((element) =>
              element.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(filteredTodos: filteredTodos));
  }
}
