const config = require("../config/auth.config");
const db = require("../models");
const User = db.user;
const Role = db.role;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

exports.signup = (req, res) => {
    const user = new User({
        username: req.body.username,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 8)
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
            res.send({ message: "用户注册成功!" });
        })
        .catch(err => {
            res.status(500).send({ message: err.message || "用户注册失败！" });
        });
};

exports.signin = async (req, res) => {
    try {
        const user = await User.findOne({ username: req.body.username }).populate("roles", "-__v");

        if (!user) {
            return res.status(404).send({ message: "未找到用户." });
        }

        const passwordIsValid = bcrypt.compareSync(req.body.password, user.password);

        if (!passwordIsValid) {
            return res.status(401).send({
                accessToken: null,
                message: "无效的密码!"
            });
        }

        const token = jwt.sign({ id: user._id }, config.secret, {
            algorithm: 'HS256',
            allowInsecureKeySizes: true,
            expiresIn: 86400, // 24 小时
        });

        const authorities = user.roles.map(role => "ROLE_" + role.name.toUpperCase());

        res.status(200).send({
            id: user._id,
            username: user.username,
            email: user.email,
            roles: authorities,
            accessToken: token
        });
    } catch (err) {
        res.status(500).send({ message: err.message || "登录失败！" });
    }
};
