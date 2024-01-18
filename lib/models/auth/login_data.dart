class LoginData {

  LoginData({this.sessionId, this.message, this.userId, this.cookie});

  LoginData.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    message = json['message'];
    userId = json['user_id'];
    cookie = json['cookie'];
  }
  String? sessionId;
  String? message;
  int? userId;
  String? cookie;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['session_id'] = sessionId;
    data['message'] = message;
    data['user_id'] = userId;
    data['cookie'] = cookie;
    return data;
  }
}
