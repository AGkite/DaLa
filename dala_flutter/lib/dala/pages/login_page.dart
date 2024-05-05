import 'package:dala_flutter/dala/core/hi_error.dart';
import 'package:dala_flutter/dala/core/hi_net_adapter.dart';
import 'package:dala_flutter/dala/dao/login_dao.dart';
import 'package:dala_flutter/dala/widget/appbar.dart';
import 'package:dala_flutter/dala/widget/login_button.dart';
import 'package:dala_flutter/dala/widget/login_effect.dart';
import 'package:dala_flutter/dala/widget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {

      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              title: '用户名',
              hint: '请输入用户',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: '密码',
              hint: '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: LoginButton(
              title: '登录',
              enable: loginEnable,
              onPressed: send,
            )),
          ],
        ),
      )
    );
  }
  void checkInput() {
    bool enable;
    if(userName != null && password!=null) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try{
      HiNetResponse<dynamic> response = await LoginDao.login(userName!, password!);
      print(response.message);
      if (response.errorCode == 0) {
        print('登录成功');
        BotToast.showText(text: "登录成功",contentColor: Colors.green);
      } else {
        print(response.message);
        BotToast.showText(text: response.message!);
      }
    } on HiNetError catch(e) {
      print(e);
      BotToast.showText(text: e.message!,contentColor: Colors.red);
    }
  }
}
