// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class SetFilteredTodosEvent extends FilteredTodosEvent {
  final Filter filter;
  final List<Todo> todoList;
  final String searchTerm;

  const SetFilteredTodosEvent({
    required this.filter,
    required this.todoList,
    required this.searchTerm,
  });

  @override
  List<Object> get props => [filter, todoList, searchTerm];

  @override
  String toString() =>
      'SetFilteredTodosEvent(filter: $filter, todoList: $todoList, searchTerml: $searchTerm)';
}
