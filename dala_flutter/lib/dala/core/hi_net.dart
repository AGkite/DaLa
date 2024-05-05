
import 'package:dala_flutter/dala/core/dio_adapter.dart';
import 'package:dala_flutter/dala/core/hi_error.dart';
import 'package:dala_flutter/dala/core/hi_net_adapter.dart';
import 'package:dala_flutter/dala/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet? getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse<dynamic>? response = HiNetResponse();
    var error;
    try {
      response = await send(request);
    } on HiNetError catch(e) {
      error = e;
      printLog(e.message);
    } catch(e) {
      // 其它错误
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }
    // 异常
    var errorCode = response?.errorCode;
    if (errorCode != 0) {
      throw HiNetError(errorCode, response?.message);
    }

    return response;
  }


  Future<dynamic> send<T>(BaseRequest request) async {
    // 使用dio发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}