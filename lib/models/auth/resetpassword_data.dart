class ResetPasswordData {

  ResetPasswordData({this.email, this.message});

  ResetPasswordData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    message = json['message'];
  }
  String? email;
  String? message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['message'] = message;
    return data;
  }
}
