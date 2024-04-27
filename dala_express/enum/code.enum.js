// 响应异常码
class ResponseCodeEnum {
    constructor(errorCode, errorMessage) {
      this.errorCode = errorCode;       // 错误码
      this.errorMessage = errorMessage; // 错误消息
    }
    // ----------- 通用异常状态码 -----------
    static get SYSTEM_ERROR() {
      return new ResponseCodeEnum(10000, '出错啦，后台小哥正在努力修复中...');
    }
    static get PARAM_NOT_VALID() {
      return new ResponseCodeEnum(10001, '参数错误！');
    }
  
    // ----------- 业务异常状态码 -----------
    static get LOGIN_FAIL() {
        return new ResponseCodeEnum(20000, "登录失败！");
    }
    static get REGISTER_FAIL() {
      return new ResponseCodeEnum(20001, "用户注册失败");
    }
    static get USERNAME_OR_PWD_ERROR() {
        return new ResponseCodeEnum(20002, "用户名或密码错误！");
    }
    static get UNAUTHORIZED() {
        return new ResponseCodeEnum(20003, "无访问权限，请先登录！");
    }
    static get USERNAME_NOT_FOUND() {
        return new ResponseCodeEnum(20004, "该用户不存在！");
    }
    static get USERNAME_IS_EXISTED() {
      return new ResponseCodeEnum(20005, "失败！用户名已经存在！");
    }
    static get EMAIL_IS_EXISTED() {
      return new ResponseCodeEnum(20006, "失败！邮箱已经存在！");
    }
    static get MOBILE_IS_EXISTED() {
      return new ResponseCodeEnum(20007, "失败！手机已经存在！");
    }
    static get ROLE_NOT_FOUND() {
      return new ResponseCodeEnum(20008, "失败！角色不存在！");
    }
    static get ILLEGAL_TOKEN() {
      return new ResponseCodeEnum(20009, "Token 不可用！");
    }
    static get NEED_ADMIN() {
      return new ResponseCodeEnum(20010, "需要管理员角色!");
    }
    
  }
  
  module.exports = ResponseCodeEnum;
  