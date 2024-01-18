class RegisterData {

  RegisterData({this.userId, this.s, this.cookie});

  RegisterData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    s = json['s'];
    cookie = json['cookie'];
  }
  int? userId;
  String? s;
  String? cookie;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['s'] = s;
    data['cookie'] = cookie;
    return data;
  }
}
