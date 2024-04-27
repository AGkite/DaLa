const { verifySignUp } = require("../middleware");
const controller = require("../controller/auth.controller");

module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });
/**
 * @swagger
 * /api/auth/signup:
 *   post:
 *     summary: 用户注册接口
 *     tags:
 *       - 公共接口
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *               password:
 *                 type: string
 *               email:
 *                 type: string
 *               mobile:
 *                 type: string
 *               roles:
 *                 type: array
 *                 items:
 *                   type: string
 *     responses:
 *       '200':
 *         description: 注册成功
 */
  app.post(
    "/api/auth/signup",
    [
      verifySignUp.checkDuplicateField,
      verifySignUp.checkRolesExisted
    ],
    controller.signup
  );

/**
 * @swagger
 * /api/auth/signin:
 *   post:
 *     summary: 用户登录接口
 *     tags:
 *       - 公共接口
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       '200':
 *         description: 登录成功
 */
  app.post("/api/auth/signin", controller.signin);
};