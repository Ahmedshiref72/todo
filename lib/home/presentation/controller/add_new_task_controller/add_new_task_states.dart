import 'package:equatable/equatable.dart';
import 'package:todo/home/presentation/data/task_model.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {
  final Task todo;

  const TodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoFailure extends TodoState {
  final String error;

  const TodoFailure(this.error);

  @override
  List<Object> get props => [error];
}
