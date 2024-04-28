
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
    HiNetResponse<dynamic>? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch(e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch(e) {
      // 其它错误
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    var status = response?.statusCode;
    switch(status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      defalut:
        throw HiNetError(status!, result.toString(), data: result);
    }
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