
import 'package:dala_flutter/dala/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }
// 基础请求

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;
  String authority() {
    return "127.0.0.1:8080";
  }
  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http 和 https 的切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if(needLogin()) {
      //给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    print('url:${uri.toString()}');
    return uri.toString();
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