import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/menu_drawer.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({super.key});

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {
  double centerAreaHeight = 0.0;
  final GlobalKey _centerAreaKey = GlobalKey();
  final List<MenuItemData> _menuItems = const [
    MenuItemData(value: "搭子", iconSrc: 'images/搭子.png'),
    MenuItemData(value: "足球", iconSrc: 'images/足球.png'),
    MenuItemData(value: "篮球", iconSrc: 'images/篮球.png'),
    MenuItemData(value: "羽毛球", iconSrc: 'images/羽毛球.png'),
    MenuItemData(value: "易烊千玺", iconSrc: 'images/易烊千玺.png'),
    MenuItemData(value: "搭子", iconSrc: 'images/搭子.png'),
    MenuItemData(value: "足球", iconSrc: 'images/足球.png'),
    MenuItemData(value: "篮球", iconSrc: 'images/篮球.png'),
    MenuItemData(value: "羽毛球", iconSrc: 'images/羽毛球.png'),
    MenuItemData(value: "易烊千玺", iconSrc: 'images/易烊千玺.png'),
    MenuItemData(value: "搭子", iconSrc: 'images/搭子.png'),
    MenuItemData(value: "足球", iconSrc: 'images/足球.png'),
    MenuItemData(value: "篮球", iconSrc: 'images/篮球.png'),
    MenuItemData(value: "羽毛球", iconSrc: 'images/羽毛球.png'),
    MenuItemData(value: "易烊千玺", iconSrc: 'images/易烊千玺.png'),
    MenuItemData(value: "篮球", iconSrc: 'images/篮球.png'),
    MenuItemData(value: "羽毛球", iconSrc: 'images/羽毛球.png'),
    MenuItemData(value: "易烊千玺", iconSrc: 'images/易烊千玺.png'),
    MenuItemData(value: "搭子", iconSrc: 'images/搭子.png'),
    MenuItemData(value: "足球", iconSrc: 'images/足球.png'),
    MenuItemData(value: "篮球", iconSrc: 'images/篮球.png'),
    MenuItemData(value: "羽毛球", iconSrc: 'images/羽毛球.png'),
    MenuItemData(value: "易烊千玺", iconSrc: 'images/易烊千玺.png'),
  ];

  @override
  void initState() {
    super.initState();
  }

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
              child: Row(
                // 将行中的两个组件放在两边
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuDrawer<String>(
                    offsetStartTop: topPadding + 60,
                    radius: 40,
                    child: _menuItems,
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
            centerAreaContainer(_centerAreaKey, mediaWidth),
          ],
        ),
      ),
    );
  }
}

Widget centerAreaContainer(Key? key, double? width) {
  return Expanded(
    child: Container(
      key: key,
      width: width,
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
  );
}
