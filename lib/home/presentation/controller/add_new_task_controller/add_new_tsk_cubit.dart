import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../shared/network/dio_helper.dart';
import '../../data/task_model.dart';
import 'add_new_task_states.dart';


class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  void createTodo({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  }) async {
    emit(TodoLoading());
    try {
      final response = await DioHelper.postData(
        url: '/todos',
        data: {
          'image': image,
          'title': title,
          'desc': desc,
          'priority': priority,
          'dueDate': dueDate,
        },
      );
      final todo = Task.fromJson(response.data);
      emit(TodoSuccess(todo));
    } catch (error) {
      emit(TodoFailure(error.toString()));
    }
  }
}
