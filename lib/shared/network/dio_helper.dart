import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/presentation/controller/auth_cubit.dart'; // Update this path as needed

class DioHelper {
  static Dio? dio;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://todo.iraqsapp.com',
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(DioLogger()); // For logging requests
    dio!.interceptors.add(RefreshTokenInterceptor(navigatorKey)); // Add the interceptor with navigatorKey
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio!.options.headers['Authorization'] = 'Bearer $token';
      }
      return await dio!.get(
        url,
        queryParameters: query,
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio!.options.headers['Authorization'] = 'Bearer $token';
      }
      dio!.options.headers['Content-Type'] = 'application/json';
      return await dio!.post(
        url,
        queryParameters: query,
        data: data,
      );
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != null) {
        final errorResponse = ErrorResponseModel.fromJson(e.response!.data);
        throw Exception(errorResponse.message);
      } else {
        throw Exception(e.message);
      }
    }
  }

  static Future<Response> putData({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio!.options.headers['Authorization'] = 'Bearer $token';
      }
      dio!.options.headers['Content-Type'] = 'application/json';
      return await dio!.put(
        url,
        queryParameters: query,
        data: data,
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio!.options.headers['Authorization'] = 'Bearer $token';
      }
      dio!.options.headers['Content-Type'] = 'application/json';
      return await dio!.patch(
        url,
        queryParameters: query,
        data: data,
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}



class RefreshTokenInterceptor extends Interceptor {
  final GlobalKey<NavigatorState> navigatorKey;

  RefreshTokenInterceptor(this.navigatorKey);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');
      final token = prefs.getString('token');

      if (refreshToken != null) {
        try {
          final refreshResponse = await Dio().get(
            'https://todo.iraqsapp.com/auth/refresh-token',
            queryParameters: {'token': refreshToken},
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );

          if (refreshResponse.statusCode == 200) {
            final newAccessToken = refreshResponse.data['access_token'];
            final newRefreshToken = refreshResponse.data['refresh_token'];
            // Save new tokens
            prefs.setString('token', newAccessToken);
            prefs.setString('refreshToken', newRefreshToken);
            // Retry the original request with the new access token
            final originalRequest = err.requestOptions;
            originalRequest.headers['Authorization'] = 'Bearer $newAccessToken';
            final retryResponse = await Dio().fetch(originalRequest);
            return handler.resolve(retryResponse);
          } else {
            _handleRefreshTokenError(prefs);
          }
        } catch (e) {
          _handleRefreshTokenError(prefs);
        }
      } else {
        _handleRefreshTokenError(prefs);
      }
    } else if (err.response?.statusCode == 403) {
      _handleRefreshTokenError(await SharedPreferences.getInstance());
    } else if (err.response?.statusCode == 404) {
      // Handle 404 error - Endpoint not found
      // Possibly redirect to login or show error
    }

    super.onError(err, handler);
  }

  void _handleRefreshTokenError(SharedPreferences prefs) {
    prefs.remove('token');
    prefs.remove('refreshToken');
    // Navigate to login screen
    navigatorKey.currentState?.pushNamedAndRemoveUntil('/loginScreen', (Route<dynamic> route) => false);
  }
}

class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('--- Request ---');
    print('Method: ${options.method}');
    print('URL: ${options.uri}');
    print('Headers: ${options.headers}');
    print('Query Parameters: ${options.queryParameters}');
    if (options.data != null) {
      print('Data: ${options.data}');
    }
    print('----------------');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('--- Response ---');
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    print('----------------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('--- Error ---');
    print('Error: ${err.message}');
    if (err.response != null) {
      print('Status Code: ${err.response?.statusCode}');
      print('Response Data: ${err.response?.data}');
    }
    print('----------------');
    super.onError(err, handler);
  }
}