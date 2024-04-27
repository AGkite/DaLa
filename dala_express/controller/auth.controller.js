const config = require("../config/auth.config");
const db = require("../models");
const Response = require("../utils/response");
const { ResponseCodeEnum } = require("../enum");
const User = db.user;
const Role = db.role;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

// 注册
exports.signup = (req, res) => {
    const user = new User({
        username: req.body.username,
        password: bcrypt.hashSync(req.body.password, 8),
        email: req.body.email,
        mobile: req.body.mobile,
        remark: req.body.remark,
    });

    user.save()
        .then(savedUser => {
            if (req.body.roles) {
                return Role.find({ name: { $in: req.body.roles } })
                    .then(roles => {
                        savedUser.roles = roles.map(role => role._id);
                        return savedUser.save();
                    });
            } else {
                return Role.findOne({ name: "user" })
                    .then(role => {
                        savedUser.roles = [role._id];
                        return savedUser.save();
                    });
            }
        })
        .then(() => {
            res.send(Response.success('用户注册成功！'));
        })
        .catch(err => {
            res.status(500).send(Response.fail(ResponseCodeEnum.REGISTER_FAIL));
        });
};

// 登录
exports.signin = async (req, res) => {
    try {
        const user = await User.findOne({ username: req.body.username }).populate("roles", "-__v");

        if (!user) {
            // 用户不存在
            return res.status(404).send(Response.fail(ResponseCodeEnum.USERNAME_NOT_FOUND));
        }
        // 验证密码
        const passwordIsValid = bcrypt.compareSync(req.body.password, user.password);

        if (!passwordIsValid) {
            return res.status(401).send(Response.fail(ResponseCodeEnum.USERNAME_OR_PWD_ERROR));
        }
        // 生成Token
        const token = jwt.sign({ id: user._id }, config.secret, {
            algorithm: 'HS256',
            allowInsecureKeySizes: true,
            expiresIn: 86400, // 24 小时
        });

        const authorities = user.roles.map(role => "ROLE_" + role.name.toUpperCase());

        res.status(200).send(Response.success("登录成功！",{
            id: user._id,
            username: user.username,
            email: user.email,
            mobile: user.mobile,
            remark: user.remark,
            roles: authorities,
            accessToken: token
        }));
    } catch (err) {
        console.log(err)
        res.status(500).send(Response.fail(ResponseCodeEnum.LOGIN_FAIL));
    }
};
