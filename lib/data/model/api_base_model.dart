class BaseResponse<T> {
  final int code;
  final String status;
  final String message;
  final T? data;

  BaseResponse({
    required this.code,
    required this.status,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T? Function(Map<String, dynamic>) fromJsonT) {
    return BaseResponse(
      code: json['code'] as int,
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}
