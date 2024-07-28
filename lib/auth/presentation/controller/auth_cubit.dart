import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/network/dio_helper.dart';
import '../data/register.dart';
import '../data/login.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> register({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  }) async {
    emit(AuthRegisterLoading());
    try {
      final response = await DioHelper.postData(
        url: '/auth/register',
        data: {
          'phone': phone,
          'password':password,
          'displayName': displayName,
          'experienceYears': experienceYears,
          'address': address,
          'level': level,
        },
      );

      final data = response.data;
      final authModel = AuthModel.fromJson(data);
      emit(AuthRegisterSuccess(authModel));

      print(response.data);
      print('Registration successful');
    } catch (error) {
      if (error is DioError) {
        if (error.response != null) {
          final errorResponse =
              ErrorResponseModel.fromJson(error.response!.data);
          emit(AuthRegisterError(errorResponse.message));
          print('Registration failed: ${errorResponse.toJson()}');
        } else {
          emit(AuthRegisterError(' ${error.message}'));
          print('Unexpected error: $error');
        }
      } else {
        emit(AuthRegisterError(' $error'));
        print('Unexpected error: $error');
      }
    }
  }

  Future<void> login(
    String phone,
    String password,
  ) async {
    emit(AuthLoginLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await DioHelper.postData(
        url: '/auth/login',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        final loginModel = LoginModel.fromJson(data);
        prefs.setString('token', loginModel.accessToken);
        prefs.setString('refreshToken', loginModel.refreshToken);
        prefs.setString('id', loginModel.id);
        emit(AuthLoginSuccess(loginModel));
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to login';
        emit(AuthLoginError(errorMessage));
      }
    } catch (error) {
      if (error is DioError && error.response != null) {
        final errorMessage =
            error.response?.data['message'] ?? 'Unexpected error occurred';
        emit(AuthLoginError(errorMessage));
      } else {
        emit(AuthLoginError(error.toString()));
        print('$error');
      }
    }
  }

  bool isObsecured=true;

  void changeVisibility()
  {
    isObsecured=!isObsecured;
    emit(ChangeVisibilityState());
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

}

class ErrorResponseModel {
  final String message;
  final String error;
  final int statusCode;

  ErrorResponseModel({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      message: json['message'],
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
      'statusCode': statusCode,
    };
  }
}
