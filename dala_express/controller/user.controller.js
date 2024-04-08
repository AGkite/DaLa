exports.allAccess = (req, res) => {
    res.status(200).send("公共内容.");
};

exports.userBoard = (req, res) => {
    res.status(200).send("用户内容.");
};

exports.adminBoard = (req, res) => {
    res.status(200).send("管理员内容.");
};

exports.moderatorBoard = (req, res) => {
    res.status(200).send("测试员内容.");
};