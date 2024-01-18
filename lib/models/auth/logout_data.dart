class LogoutData {

  LogoutData({this.message});

  LogoutData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
