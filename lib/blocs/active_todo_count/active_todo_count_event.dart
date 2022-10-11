// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

class ChangeActiveTodoCountEvent extends ActiveTodoCountEvent {
  final int newActiveTodoCount;
  const ChangeActiveTodoCountEvent({
    required this.newActiveTodoCount,
  });

  @override
  List<Object> get props => [newActiveTodoCount];

  @override
  String toString() =>
      'ChangeActiveTodoCountEvent(newActiveTodoCount: $newActiveTodoCount)';
}
