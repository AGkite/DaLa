

import 'package:dala_flutter/dala/request/base_request.dart';

class RegistrationRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/api/auth/signup";
  }

}