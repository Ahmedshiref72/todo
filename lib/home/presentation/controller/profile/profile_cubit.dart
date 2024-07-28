import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:todo/home/presentation/controller/profile/profile_states.dart';

import '../../../../shared/network/dio_helper.dart';
import '../../data/profile_model.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final response = await DioHelper.getData(
        url: '/auth/profile',

      );
      final profile = ProfileModel.fromJson(response.data);
      emit(ProfileLoaded(profile: profile));
    } on DioError catch (e) {
      emit(ProfileError(message: e.message));
    }
  }
}
