const Response = require("../utils/response");
const { ResponseCodeEnum } = require("../enum");
const db = require("../models");
const ROLES = db.ROLES;
const User = db.user;

checkDuplicateField = async (req, res, next) => {
    try {
        // username
        let user = await User.findOne({ username: req.body.username }).exec();
        if (user) {
            return res.status(400).send(Response.fail(ResponseCodeEnum.USERNAME_IS_EXISTED));
        }

        // email
        user = await User.findOne({ email: req.body.email }).exec();
        if (user) {
            return res.status(400).send(Response.fail(ResponseCodeEnum.EMAIL_IS_EXISTED));
        }

        // mobile
        user = await User.findOne({ mobile: req.body.mobile }).exec();
        if (user) {
            return res.status(400).send(Response.fail(ResponseCodeEnum.MOBILE_IS_EXISTED));
        }

        next();
    } catch (err) {
        res.status(500).send(Response.fail(ResponseCodeEnum.PARAM_NOT_VALID));
    }
};

checkRolesExisted = (req, res, next) => {
    if (req.body.roles) {
        for (let i = 0; i < req.body.roles.length; i++) {
            if (!ROLES.includes(req.body.roles[i])) {
                res.status(400).send(Response.fail(ResponseCodeEnum.ROLE_NOT_FOUND));
                return;
            }
        }
    }
    next();
}

const verifySignUp = {
    checkDuplicateField,
    checkRolesExisted
};

module.exports = verifySignUp;