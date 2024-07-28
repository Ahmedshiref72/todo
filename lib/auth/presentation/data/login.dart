class LoginModel {
  final String id;
  final String accessToken;
  final String refreshToken;

  LoginModel({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['_id'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
class ErrorResponseModel {
  final String message;

  ErrorResponseModel({required this.message});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
