const { authJwt } = require("../middleware");
const controller = require("../controller/user.controller");

module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

/**
 * @swagger
 * tags:
 *   - name: 公共接口
 *     description: 所有用户都可以访问的接口
 */

/**
 * @swagger
 * /api/test/all:
 *   get:
 *     summary: 获取公共内容
 *     tags:
 *       - 公共接口
 *     responses:
 *       '200':
 *         description: 成功获取公共内容
 */
    app.get("/api/test/all", controller.allAccess);

/**
 * @swagger
 * tags:
 *   - name: 用户接口
 *     description: 需要用户身份验证的接口
 */

/**
 * @swagger
 * /api/test/user:
 *   get:
 *     summary: 获取用户信息
 *     tags:
 *       - 用户接口
 *     parameters:
 *       - in: header
 *         name: x-access-token
 *         schema:
 *           type: string
 *         required: true
 *     responses:
 *       '200':
 *         description: 成功获取用户信息
 */
    app.get("/api/test/user", [authJwt.verifyToken], controller.userBoard);

/**
 * @swagger
 * tags:
 *   - name: 管理员接口
 *     description: 需要管理员身份验证的接口
 */

/**
 * @swagger
 * /api/test/admin:
 *   get:
 *     summary: 获取管理员信息
 *     tags:
 *       - 管理员接口
 *     parameters:
 *       - in: header
 *         name: x-access-token
 *         schema:
 *           type: string
 *         required: true
 *     responses:
 *       '200':
 *         description: 成功获取管理员信息
 */
    app.get(
        "/api/test/admin",
        [authJwt.verifyToken, authJwt.isAdmin],
        controller.adminBoard
    );
};