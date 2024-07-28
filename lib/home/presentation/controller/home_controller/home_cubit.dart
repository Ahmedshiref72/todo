import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart'; // Make sure you have Dio added in your pubspec.yaml
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/shared/network/dio_helper.dart';
import 'package:todo/shared/utils/app_values.dart';

import '../../data/task_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
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

      if (response.statusCode == 200 || response.statusCode == 201) {
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
      print('Error fetching tasks: $e');
      emit(HomeErrorState('An error occurred'));
    }
  }

  Future<void> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? refreshToken = prefs.getString('refreshToken');

      if (token == null || refreshToken == null) {
        throw Exception('Token not found');
      }

      final response = await DioHelper.postData(
        url: 'https://todo.iraqsapp.com/auth/logout',
        data: {
          'token': refreshToken,
        },
        token: token,
      );

      if (response.statusCode == 201|| response.statusCode == 200) {
        await prefs.remove('token');
        await prefs.remove('refreshToken');
        emit(LogOutSuccessState());
      } else {
        throw Exception('Failed to log out: ${response.statusCode}');
      }
    } catch (e) {
      print('Error logging out: $e');
      emit(LogOutErrorState('Failed to log out'));
    }
  }
}
