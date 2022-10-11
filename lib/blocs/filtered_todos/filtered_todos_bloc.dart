// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/models.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final List<Todo> initialTodos;
  FilteredTodosBloc({required this.initialTodos})
      : super(FilteredTodosState(filteredTodos: initialTodos)) {
    on<SetFilteredTodosEvent>((event, emit) {
      List<Todo> filteredTodos;
      switch (event.filter) {
        case Filter.active:
          filteredTodos =
              event.todoList.where((element) => !element.isCompleted).toList();
          break;
        case Filter.completed:
          filteredTodos =
              event.todoList.where((element) => element.isCompleted).toList();
          break;
        case Filter.all:
        default:
          filteredTodos = event.todoList;
          break;
      }
      if (event.searchTerm.isNotEmpty) {
        filteredTodos = filteredTodos
            .where((element) => element.desc
                .toLowerCase()
                .contains(event.searchTerm.toLowerCase()))
            .toList();
      }
      emit(state.copyWith(filteredTodos: filteredTodos));
    });
  }
}
