
import 'dart:ffi';

import 'package:dala_flutter/dala/core/hi_net.dart';
import 'package:dala_flutter/dala/core/hi_net_adapter.dart';
import 'package:dala_flutter/dala/db/hi_cache.dart';
import 'package:dala_flutter/dala/request/base_request.dart';
import 'package:dala_flutter/dala/request/login_request.dart';
import 'package:dala_flutter/dala/request/registration_request.dart';

class LoginDao {
  static const ACCESS_TOKEN = "accessToken";
  static login(String userName, String password) async {
    BaseRequest request = LoginRequest();
    request
        .add("username", userName)
        .add("password",password);

    HiNetResponse<dynamic> response = await HiNet.getInstance()?.fire(request);
    if(response.errorCode == 0 && response.data['accessToken'] != null){
      // 保存登陆令牌
      HiCache.getInstance()?.setString(ACCESS_TOKEN, response.data['accessToken']);
    }
    return response;

  }
  static registration(String userName, String password, String email, String mobile, List<String> roles) async {
    BaseRequest request = RegistrationRequest();
    request
        .add("username", userName)
        .add("password",password)
        .add("email", email)
        .add("mobile", mobile)
        .add("roles", roles);

    var result = await HiNet.getInstance()?.fire(request);
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance()?.get(ACCESS_TOKEN);
  }
}
