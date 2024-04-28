import 'package:dala_flutter/dala/core/hi_error.dart';
import 'package:dala_flutter/dala/dao/login_dao.dart';
import 'package:dala_flutter/dala/utils/string_util.dart';
import 'package:dala_flutter/dala/widget/appbar.dart';
import 'package:dala_flutter/dala/widget/login_effect.dart';
import 'package:dala_flutter/dala/widget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({super.key, required this.onJumpToLogin});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? email;
  String? mobile;
  List<String>? roles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", widget.onJumpToLogin),
      body: Container(
        child: ListView(
          // 自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(protect: true,),
            LoginInput(
                title: "用户名",
                hint: "请输入用户名",
              onChanged: (text) {
                  userName = text;
                  checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "确认密码",
              hint: "请再次输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "邮箱",
              hint: "请输入邮箱",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                email = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "手机号",
              hint: "请输入手机号",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                mobile = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if(isNotEmpty(userName!) &&
        isNotEmpty(password!) &&
        isNotEmpty(rePassword!) &&
        isNotEmpty(email!) &&
        isNotEmpty(mobile!)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
      onTap: (){
        if(loginEnable) {
          checkParams();
        } else {
          print('请填写完整信息');
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: loginEnable ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '注册',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void send() async {
    try{
      // 设置默认角色
      roles ??= ["user"];
      var result =
          await LoginDao.registration(userName!, password!, email!, mobile!, roles!);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print(result['msg']);
      }
    } on NeedAuth catch(e) {
      print(e);
    } on NeedLogin catch(e) {
      print(e);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (mobile?.length != 11) {
      tips = '手机号输入错误';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
