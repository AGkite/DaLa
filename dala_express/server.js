const express = require("express");
const cors = require("cors");
const swaggerJSDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const app = express();

// 生成 swagger 接口文档
const swaggerOptions = {
    swaggerDefinition: {
        openapi: '3.0.0',
        info: {
            title: 'Dala 项目后端接口文档',
            version: '1.0.0',
            description: 'Dala 项目后端接口文档',
        }
    },
    apis: ['./routes/*.js'], // 路由文件的路径
};
const swaggerSpec = swaggerJSDoc(swaggerOptions);

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// 跨域资源共享
var corsOptions = {
    origin: "http://localhost:8081"
};
app.use(cors(corsOptions));

// 解析内容类型为 application/json 的请求, 处理发送到服务器的 JSON 格式请求体
app.use(express.json());

// 解析内容类型为 application/x-www-form-urlencoded 的请求, 一般为表单数据
app.use(express.urlencoded({ extended: true }));

// 连接 MongoDB 
const db = require("./models");
const dbConfig = require("./config/db.config");
const Role = db.role;

db.mongoose
    .connect(`mongodb://${dbConfig.HOST}:${dbConfig.PORT}/${dbConfig.DB}`)
    .then(() => {
        console.log("成功连接到 MongoDB ...");
        initial();
    })
    .catch(err => {
        console.log("连接失败！", err);
        process.exit();
    });

function initial() {
    Role.estimatedDocumentCount()
        .then((count) => {
            if (count === 0) {
                const saveRolesPromises = [
                    new Role({ name: "user" }).save(),
                    new Role({ name: "moderator" }).save(),
                    new Role({ name: "admin" }).save()
                ];

                Promise.all(saveRolesPromises)
                    .then(results => {
                        results.forEach(result => {
                            console.log(`增加一个 '${result.name}' 到 roles 集合`);
                        });
                    })
                    .catch(err => {
                        console.error("保存角色时出错:", err);
                    });
            }
        }).catch(err => console.log("计算文档数量时出错：", err));
}

// routes
app.get("/", (req, res) => {
    res.json({ message: "dala_express 后端测试。" });
});

require('./routes/auth.routes')(app);
require('./routes/user.routes')(app);

// 可自定义端口, 默认 8080
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
    console.log(`dala_express 服务运行在端口: ${PORT} ...`);
})

