import 'package:equatable/equatable.dart';

import '../../data/task_model.dart';

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

class ImageUploadLoading extends TodoState {}

class ImageUploadSuccess extends TodoState {
  final String imageUrl;

  const ImageUploadSuccess(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ImageUploadFailure extends TodoState {
  final String error;

  const ImageUploadFailure(this.error);

  @override
  List<Object> get props => [error];
}
