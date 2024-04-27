const Response = require("../utils/response");

exports.allAccess = (req, res) => {
    res.status(200).send(Response.success(null,{
        content: "公共内容"
    }));
};

exports.userBoard = (req, res) => {
    res.status(200).send(Response.success(null,{
        content: "用户内容"
    }));
};

exports.adminBoard = (req, res) => {
    res.status(200).send(Response.success(null,{
        content: "管理员内容"
    }));
};
