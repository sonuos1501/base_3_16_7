/// T is ResponseData when success
class Responses<T> {
  Responses({
    this.apiStatus,
    this.apiVersion,
    this.successType,
    this.data,
    this.errors,
  });

  Responses.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT, {
    bool isListData = false,
  }) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    successType = json['success_type'];
    message = json['message'];
    data = json['data'] != null && fromJsonT != null
      ? fromJsonT.call(isListData ? json : json['data'])
      : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  String? apiStatus;
  String? apiVersion;
  String? successType;
  String? message;
  T? data;
  Errors? errors;

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T?)? toJsonT) {
    final data = <String, dynamic>{};
    data['api_status'] = apiStatus;
    data['api_version'] = apiVersion;
    data['success_type'] = successType;
    data['message'] = message;
    if (this.data != null && toJsonT != null) {
      data['data'] = toJsonT.call(this.data);
    }
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  Errors({this.errorId, this.errorText});

  Errors.fromJson(Map<String, dynamic> json) {
    errorId = json['error_id'];
    errorText = json['error_text'] != null
      ? json['error_text'] is List
       ? (json['error_text'] as List).join('\n')
       : json['error_text']
      : null;
  }
  String? errorId;
  String? errorText;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_id'] = errorId;
    data['error_text'] = errorText;
    return data;
  }
}
