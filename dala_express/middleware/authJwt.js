const jwt = require("jsonwebtoken");
const config = require("../config/auth.config.js");
const db = require("../models");
const User = db.user;
const Role = db.role;

verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];

    if (!token) {
        return res.status(403).send({ message: "未提供令牌！" });
    }
    jwt.verify(token, config.secret, (err, decoded) => {
        if (err) {
            return res.status(401).send({
                message: "未经授权！"
            });
        }
        req.userId = decoded.id;
        next();
    });
};
isAdmin = async (req, res, next) => {
    try {
        const user = await User.findById(req.userId).exec();
        if (!user) {
            return res.status(404).send({ message: "未找到用户." });
        }

        const roles = await Role.find({ _id: { $in: user.roles } }).exec();
        if (!roles) {
            return res.status(403).send({ message: "需要管理员角色!" });
        }

        for (let i = 0; i < roles.length; i++) {
            if (roles[i].name === "admin") {
                return next();
            }
        }

        res.status(403).send({ message: "需要管理员角色!" });
    } catch (err) {
        res.status(500).send({ message: err.message || "检查管理员权限时出错！" });
    }
};

isModerator = async (req, res, next) => {
    try {
        const user = await User.findById(req.userId).exec();
        if (!user) {
            return res.status(404).send({ message: "未找到用户." });
        }

        const roles = await Role.find({ _id: { $in: user.roles } }).exec();
        if (!roles) {
            return res.status(403).send({ message: "需要主持人角色!" });
        }

        for (let i = 0; i < roles.length; i++) {
            if (roles[i].name === "moderator") {
                return next();
            }
        }

        res.status(403).send({ message: "需要主持人角色!" });
    } catch (err) {
        res.status(500).send({ message: err.message || "检查主持人权限时出错！" });
    }
};

const authJwt = {
    verifyToken,
    isAdmin,
    isModerator
};
module.exports = authJwt;