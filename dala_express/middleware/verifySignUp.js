const db = require("../models");
const ROLES = db.ROLES;
const User = db.user;

checkDuplicateUsernameOrEmail = async (req, res, next) => {
    try {
        // username
        let user = await User.findOne({ username: req.body.username }).exec();
        if (user) {
            return res.status(400).send({ message: "失败！用户名已经存在！" });
        }

        // email
        user = await User.findOne({ email: req.body.email }).exec();
        if (user) {
            return res.status(400).send({ message: "失败！邮箱已经存在！" });
        }

        // phone
        user = await User.findOne({ phone: req.body.phone }).exec();
        if (user) {
            return res.status(400).send({ message: "失败！手机已经存在！" });
        }

        next();
    } catch (err) {
        res.status(500).send({ message: err.message || "检查重复用户名或邮箱或手机号码时出错！" });
    }
};

checkRolesExisted = (req, res, next) => {
    if (req.body.roles) {
        for (let i = 0; i < req.body.roles.length; i++) {
            if (!ROLES.includes(req.body.roles[i])) {
                res.status(400).send({
                    message: `失败！Role ${req.body.roles[i]}不存在！`
                });
                return;
            }
        }
    }
    next();
}

const verifySignUp = {
    checkDuplicateUsernameOrEmail,
    checkRolesExisted
};

module.exports = verifySignUp;