part of 'edit_task_cubit.dart';

abstract class EditTaskState extends Equatable {
  const EditTaskState();

  @override
  List<Object> get props => [];
}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {}

class EditTaskFailure extends EditTaskState {
  final String error;

  const EditTaskFailure({required this.error});

  @override
  List<Object> get props => [error];
}
