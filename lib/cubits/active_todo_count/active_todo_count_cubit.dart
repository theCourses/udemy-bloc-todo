// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  final int initialActiveTodoCount;
  late final StreamSubscription todoSubscription;
  ActiveTodoCountCubit(
      {required this.todoListCubit, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      print(todoListState.toString());
      final int currentActiveTodoCount = todoListState.todoList
          .where((element) => !element.isCompleted)
          .toList()
          .length;
      emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoSubscription.cancel();
    return super.close();
  }
}
