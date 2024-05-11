import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context); // 获取屏幕尺寸信息
    var topPadding = mediaQuery.padding.top; // 获取刘海的顶部安全区域
    var mediaWidth = mediaQuery.size.width; // 获取屏幕宽度
    // var mediaHeight = mediaQuery.size.height; // 获取屏幕高度
    // print("屏幕刘海高度：$topPadding");
    // print("屏幕宽度：$mediaWidth");
    // print("屏幕高度：$mediaHeight");

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 60,
              width: mediaWidth,
              child: Row(
                // 将行中的两个组件放在两边
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: '搭子',
                        child: Text('搭子'),
                      ),
                      const PopupMenuItem(
                        value: '足球',
                        child: Text('足球'),
                      ),
                      const PopupMenuItem(
                        value: '篮球',
                        child: Text('篮球'),
                      ),
                      const PopupMenuItem(
                        value: '饮茶',
                        child: Text('旅游'),
                      ),
                      const PopupMenuItem(
                        value: '化妆',
                        child: Text('化妆'),
                      ),
                      const PopupMenuItem(
                        value: '软件',
                        child: Text('软件'),
                      ),
                    ],
                    onSelected: (value) {
                      // 处理操作菜单选项的回调
                      print('选中的选项: $value');
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.label),
                        ),
                      ],
                    ),
                  ),
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
                      Color(0xfff1e3d6),
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
