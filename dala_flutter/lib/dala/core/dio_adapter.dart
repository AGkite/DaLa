//Dio 适配器
import 'package:dala_flutter/dala/core/hi_net_adapter.dart';
import 'package:dala_flutter/dala/request/base_request.dart';
import 'package:dio/dio.dart';

import 'hi_error.dart';

// Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    RequestOptions requestOptions = RequestOptions();
    Response response = Response(requestOptions: requestOptions);
    Dio dio = Dio();
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await dio.get(request.url(), options: Options(headers: request.header));
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await dio.post(request.url(), data:request.params, options: Options(headers: request.header));
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await dio.delete(request.url(), data:request.params, options: Options(headers: request.header));
      }
    } on DioException catch(e) {
      // 如果出现Dio错误，则抛出HiNetError
      throw HiNetError(e.response?.statusCode ?? -1, e.message, data: e.response?.data);
    } finally {
      // print("abcd:" + response.data.toString());
      // print("success:"+response.data['success'].toString());
      // print("message:"+ response.data['message'].toString());
      // print("errorCode:"+response.data['errorCode'].toString());
      // print("data:"+response.data['data'].toString());
    }

    // 构建适配后的HiNetResponse对象
    return buildRes<T>(response, request);
  }

  HiNetResponse<T> buildRes<T>(Response response, BaseRequest request) {
    return HiNetResponse<T>(
      success: response.data['success'],
      message: response.data['message'],
      data: response.data['data'],
      errorCode: response.data['errorCode'],
    );
  }
}