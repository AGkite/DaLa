
import 'dart:ffi';

import 'package:dala_flutter/dala/core/hi_net.dart';
import 'package:dala_flutter/dala/db/hi_cache.dart';
import 'package:dala_flutter/dala/request/base_request.dart';
import 'package:dala_flutter/dala/request/login_request.dart';
import 'package:dala_flutter/dala/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";
  static login(String userName, String password) {
    return _send(userName, password);
  }
  static registration(String userName, String password, String email, String mobile, List<String> roles) {
    return _send(userName, password, email: email, mobile: mobile, roles: roles);
  }

  static _send(String userName, String password, {email, mobile, roles}) async {
    BaseRequest request;
    if (email != null && mobile != null && roles != null) {
      request = RegistrationRequest();
    }else {
      request = LoginRequest();
    }

    request
    .add("userName", userName)
    .add("password",password);
    // .add("email", email)
    // .add("mobile", mobile)
    // .add("roles", roles);

    var result = await HiNet.getInstance()?.fire(request);
    print(result);
    if(result['code'] == 0 && result['data'] != null){
      // 保存登陆令牌
      HiCache.getInstance()?.setString(BOARDING_PASS, result['data']);
    }
    return result;
  }
  static getBoardingPass() {
    return HiCache.getInstance()?.get(BOARDING_PASS);
  }
}
