//Dio 适配器
import 'package:dala_flutter/dala/core/hi_net_adapter.dart';
import 'package:dala_flutter/dala/request/base_request.dart';
import 'package:dio/dio.dart';

import 'hi_error.dart';

// Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response,options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(), data:request.params, options: options);
      }else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(), data:request.params,options:options);
      }
    } on DioException catch(e) {
      error = e;
      response = e.response;
    }
    if (error!=null) {
      // 抛出HiNetError
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response,request));
    }

    return buildRes(response, request);
  }

  HiNetResponse<T> buildRes<T>(Response response, BaseRequest request) {
    return HiNetResponse<T>(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response
    );
  }
}