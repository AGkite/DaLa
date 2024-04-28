// 登录动态效果
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protect;
  const LoginEffect({super.key, required this.protect});

  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisSize:  MainAxisSize.max,
        children: [
          _image(true)
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect ? 'images/head_left_protect.png' : 'images/head_left.png';
    var headRight = widget.protect ? 'images/head_right_protect.png' : 'images/head_right.png';
    var logo = 'images/logo.png';
    return Image(
      height: 120,
      width: 360,
      image: AssetImage(logo),);
  }
}
