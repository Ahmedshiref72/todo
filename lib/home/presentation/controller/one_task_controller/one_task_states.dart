import '../../data/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final Task task;
  TaskLoaded(this.task);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
class DeleteLoading extends TaskState {}

class DeleteLoaded extends TaskState {

}

class DeleteError extends TaskState {
  final String message;
  DeleteError(this.message);
}
