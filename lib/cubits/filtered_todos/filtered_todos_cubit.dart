// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app/models/models.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  late final StreamSubscription todoFilterCubitSub;
  late final StreamSubscription todoSearchCubitSub;
  late final StreamSubscription todoListCubitSub;
  FilteredTodosCubit(
      {required this.initialTodos,
      required this.todoFilterCubit,
      required this.todoSearchCubit,
      required this.todoListCubit})
      : super(FilteredTodosState(filteredTodos: initialTodos)) {
    todoFilterCubitSub =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });

    todoSearchCubitSub =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });

    todoListCubitSub =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;
    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.todoList
            .where((element) => !element.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListCubit.state.todoList
            .where((element) => element.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.todoList;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((element) => element.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterCubitSub.cancel();
    todoSearchCubitSub.cancel();
    todoListCubitSub.cancel();
    return super.close();
  }
}
