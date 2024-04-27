// 统一请求响应类
class Response {
    constructor(success, message, errorCode, data) {
        this.success = success; // 响应是否成功的标志
        this.message = message; // 响应消息
        this.errorCode = errorCode; // 业务异常码
        this.data = data;       // 响应数据
    }

    static success(message, data) {
        return new Response(true, message, null, data ? data : null);
    }

    static fail(errorEnumOrMessage, errorCodeOrData, data) {
        if (typeof errorEnumOrMessage === 'object') {
            return new Response(false, errorEnumOrMessage.errorMessage, errorEnumOrMessage.errorCode, errorCodeOrData ? errorCodeOrData : null);
        } else {
            return new Response(false, errorEnumOrMessage, errorCodeOrData, data ? data : null);
        }
    }
}

module.exports = Response;