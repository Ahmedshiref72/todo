import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';


import '../../../../shared/network/dio_helper.dart';
import '../../data/task_model.dart';
import 'one_task_states.dart';


class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void getTaskById(String id) async {
    emit(TaskLoading());
    try {
      final response = await DioHelper.getData(
        url: '/todos/$id',
      );
      final task = Task.fromJson(response.data);
      emit(TaskLoaded(task));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}

