
import 'package:dala_flutter/dala/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }
// 基础请求

abstract class BaseRequest {
  var pathParams;
  var useHttps = false;
  String authority() {
    return "http://192.168.31.110:8080/";
  }
  HttpMethod httpMethod();
  String path();
  String url() {
    if(needLogin()) {
      //给需要登录的接口携带登录令牌
      addHeader(LoginDao.ACCESS_TOKEN, LoginDao.getBoardingPass());
    }
    String uri = "${authority()}${path()}";
    return uri;
  }

  bool needLogin();

  Map<String, String> params = Map();

  // 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {
    "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MmM3ZDQxYjI5ZTgyZDBjYjUzMGY3MCIsImlhdCI6MTcxNDI3NDM4MywiZXhwIjoxNzE0MzYwNzgzfQ.Z1NogBPVEZZs9l5ZnAzCgbflDBAm9h0aNUQWkSdeg8E",
  };
  // 添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}