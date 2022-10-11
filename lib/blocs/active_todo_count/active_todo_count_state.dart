part of 'active_todo_count_bloc.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.intial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  @override
  bool get stringify => true;
}
