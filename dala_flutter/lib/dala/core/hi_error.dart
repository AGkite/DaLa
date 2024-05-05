// // 需要登陆的异常
// class NeedLogin extends HiNetError {
//   NeedLogin({int errorCode = 20003, String message = '请先登录'}) : super(errorCode, message);
// }
//
// // 需要管理员角色
// class NeedAuth extends HiNetError {
//   NeedAuth(String message, {int errorCode = 20010, dynamic data}) : super(errorCode, message, data: data);
// }


class HiNetError implements Exception {
  final int? errorCode;
  final String? message;
  final dynamic data;
  HiNetError(this.errorCode, this.message, {this.data});
}