class AuthModel {
  final String id;
  final String token;
  final String refreshToken;
  final String displayName;

  AuthModel({
    required this.id,
    required this.token,
    required this.refreshToken,
    required this.displayName,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['_id'],
      token: json['access_token'],
      refreshToken: json['refresh_token'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'access_token': token,
      'refresh_token': refreshToken,
      'displayName': displayName,
    };
  }
}
