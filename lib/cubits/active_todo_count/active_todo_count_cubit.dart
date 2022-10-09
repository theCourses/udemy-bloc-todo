import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:todo_app/cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  late final StreamSubscription todoSubscription;
  ActiveTodoCountCubit({required this.todoListCubit})
      : super(ActiveTodoCountState.intial()) {
    todoSubscription = todoListCubit.stream.listen((TodoListState todoListState) {
      todoListState.
    });
  }

  @override
  Future<void> close() {
    todoSubscription.cancel();
    return super.close();
  }
}
