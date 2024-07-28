import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart'; // Make sure you have Dio added in your pubspec.yaml
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/shared/network/dio_helper.dart';
import 'package:todo/shared/utils/app_values.dart';

import '../../data/task_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());



  Future<void> fetchTasks() async {
    try {
      emit(HomeLoadingState());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await DioHelper.getData(
        token: token,
         url: '/todos?page=1',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final tasks = data.map((json) => Task.fromJson(json)).toList();

        final waitingTasks = tasks.where((task) => task.status == 'waiting').toList();
        final inProgressTasks = tasks.where((task) => task.status == 'inprogress').toList();
        final finishedTasks = tasks.where((task) => task.status == 'finished').toList();
        final allTasks = tasks;

        emit(HomeLoadedState(
          waitingTasks: waitingTasks,
          inProgressTasks: inProgressTasks,
          finishedTasks: finishedTasks,
          allTasks: allTasks,
        ));
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      // Log the error to help diagnose the issue
      print('Error fetching tasks: $e');
      emit(HomeErrorState('An error occurred'));
    }
  }
}
