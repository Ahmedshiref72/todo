import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/network/dio_helper.dart';

part 'edit_task_states.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());

  void updateTask({
    required String taskId,
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String status,
  }) async {
    emit(EditTaskLoading());
    try {

      SharedPreferences   sharedPreferences = await SharedPreferences.getInstance();
      String user = sharedPreferences.getString('id')!;
      print(user);
      final response = await DioHelper.putData(
        url: '/todos/$taskId',
        data:   {
          'image': image,
          'title': title,
          'desc': desc,
          'priority': priority,
          'status': status,
          "user":user
        },
      );

      if (response.statusCode == 200) {
        emit(EditTaskSuccess());
      } else {
        emit(EditTaskFailure(error: 'Failed to update task'));
      }
    } catch (error) {
      emit(EditTaskFailure(error: error.toString()));
    }
  }
}
