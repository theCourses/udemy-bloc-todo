// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todoList;

  const TodoListState({required this.todoList});

  factory TodoListState.initial() {
    return TodoListState(todoList: [
      Todo(
        id: '1',
        desc: 'First Task',
      ),
      Todo(
        id: '2',
        desc: 'Second Task',
      ),
      Todo(
        id: '3',
        desc: 'Third Task',
      ),
    ]);
  }

  @override
  List<Object> get props => [todoList];

  TodoListState copyWith({
    List<Todo>? todoList,
  }) {
    return TodoListState(
      todoList: todoList ?? this.todoList,
    );
  }

  @override
  bool get stringify => true;
}
