const jwt = require("jsonwebtoken");
const config = require("../config/auth.config.js");
const Response = require("../utils/response");
const { ResponseCodeEnum } = require("../enum");
const db = require("../models");
const User = db.user;
const Role = db.role;

// 验证 Token
verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];

    if (!token) {
        console.log(444)
        return res.status(403).send(Response.fail(ResponseCodeEnum.UNAUTHORIZED));
    }
    jwt.verify(token, config.secret, (err, decoded) => {
        if (err) {
            return res.status(401).send(Response.fail(ResponseCodeEnum.ILLEGAL_TOKEN));
        }
        req.userId = decoded.id;
        next();
    });
};
// 验证身份权限
isAdmin = async (req, res, next) => {
    try {
        const user = await User.findById(req.userId).exec();
        if (!user) {
            return res.status(404).send(Response.fail(ResponseCodeEnum.USERNAME_NOT_FOUND));
        }

        const roles = await Role.find({ _id: { $in: user.roles } }).exec();
        if (!roles) {
            return res.status(403).send(Response.fail(ResponseCodeEnum.NEED_ADMIN));
        }

        for (let i = 0; i < roles.length; i++) {
            if (roles[i].name === "admin") {
                return next();
            }
        }

        res.status(403).send(Response.fail(ResponseCodeEnum.NEED_ADMIN));
    } catch (err) {
        res.status(500).send(Response.fail("验证管理员权限出错", 10000));
    }
};


const authJwt = {
    verifyToken,
    isAdmin,
};
module.exports = authJwt;