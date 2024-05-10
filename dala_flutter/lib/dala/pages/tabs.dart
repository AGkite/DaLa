import 'package:flutter/material.dart';
import './tabs/circle.dart';
import './tabs/community.dart';
import './tabs/share.dart';
import './tabs/mate.dart';
import './tabs/my.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    CirclePage(),
    CommunityPage(),
    SharePage(),
    MatePage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true, // 不设置会造成圆角处没有透明效果
      body: _pages[_currentIndex], // 根据索引号加载相应页面
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.blue, // 背景颜色
            borderRadius: BorderRadius.circular(20)),
        child: BottomNavigationBar(
          showSelectedLabels: false, // 不展示选中标签文字
          showUnselectedLabels: false, // 不展示为选中标签文字
          type: BottomNavigationBarType.fixed, // 底部导航栏超过4个必须配置
          fixedColor: Colors.red, // 选中颜色
          currentIndex: _currentIndex, // 菜单索引号
          backgroundColor: Colors.transparent, // 设置透明背景
          elevation: 0.0, // 去除阴影
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: "搭圈"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "主页"),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: "分享"),
            BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "搭子"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "个人"),
          ],
          // 点击菜单触发的方法
          onTap: (index) {
            setState(() {
              _currentIndex = index; // 更新菜单的索引号
            });
          },
        ),
      ),
    );
  }
}
