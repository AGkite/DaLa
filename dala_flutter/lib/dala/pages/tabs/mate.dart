import 'package:flutter/material.dart';

class MatePage extends StatelessWidget {
  const MatePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context); // 获取屏幕尺寸信息
    var topPadding = mediaQuery.padding.top; // 获取刘海的顶部安全区域
    var mediaWidth = mediaQuery.size.width; // 获取屏幕宽度
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 60,
              width: mediaWidth,
              child: const Row(
                children: [
                  Icon(Icons.menu),
                ],
              ),
            ),
            // 中间高度自适应
            Expanded(
              child: Container(
                width: mediaWidth,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // 阴影颜色及透明度
                      blurRadius: 20, // 模糊半径
                      offset: const Offset(5, 5), // 阴影偏移量
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffd5a982), // 渐变色起始颜色
                      Color(0xffffffff),
                      Color(0xffffffff), // 渐变色结束颜色
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
