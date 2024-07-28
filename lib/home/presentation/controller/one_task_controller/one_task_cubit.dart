import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:todo/shared/components/toast_component.dart';
import 'package:todo/shared/utils/navigation.dart';


import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/utils/app_routes.dart';
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

  void deleteTask(String id, BuildContext context) async {
    emit(DeleteLoading());
    try {
      final response = await DioHelper.deleteData(
        url: '/todos/$id',
      );
      if (response.statusCode == 200) {
        emit(DeleteLoaded());
        showToast(text: 'تم الحذف بنجاح', state:  ToastStates.SUCCESS);
      } else {
        emit(DeleteError('حدث خطأ ما'));
        showToast(text: 'حدث خطأ ما', state: ToastStates.ERROR);
      }
    } catch (e) {
      emit(DeleteError(e.toString()));
    }
  }
}

