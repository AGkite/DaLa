import 'dart:convert';

import 'package:dala_flutter/dala/request/base_request.dart';

// 网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

// 统一网络层返回格式
class HiNetResponse<T> {
  bool? success;
  String? message;
  dynamic data;
  int? errorCode;

  HiNetResponse({this.success, this.message, this.data, this.errorCode});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}