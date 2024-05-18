import 'package:flutter/material.dart';

// 菜单抽屉
class MenuDrawer<T> extends StatefulWidget {
  final double itemWidth; // 选项的宽度
  final double itemHeight; // 选项的高度
  final List<MenuItemData> child; // 选项的列表
  final EdgeInsets itemMargin; // 选项的外边距
  final EdgeInsets itemPadding; // 选项的内边距
  final double offsetStartTop; // 子组件顶部的开始坐标值
  final EdgeInsets padding; // 子组件的内边距
  final double radius; // 子组件的圆角
  final Widget icon; // 组件的图标

  const MenuDrawer({
    super.key,
    required this.child,
    this.icon = const Icon(Icons.menu),
    this.offsetStartTop = 0.0,
    this.itemHeight = 100.0 / 2 - 15,
    this.itemWidth = 130.0 / 2 - 15,
    this.itemMargin = const EdgeInsets.all(0.0),
    this.itemPadding = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.fromLTRB(5, 20, 5, 50),
    this.radius = 50.0,
  });

  @override
  MenuDrawerState<T> createState() => MenuDrawerState<T>();
}

class MenuDrawerState<T> extends State<MenuDrawer<T>> {
  bool _isOpen = false;

  OverlayState? overlayState;
  OverlayEntry? entry;
  RenderBox? renderBox;
  late int length;
  late double width;
  late double height;
  late EdgeInsets itemMargin;
  late double itemMarginLeft;
  late double itemMarginRight;
  late double itemMarginTop;
  late double itemMarginBottom;
  late EdgeInsets itemPadding;
  late double itemPaddingLeft;
  late double itemPaddingRight;
  late double itemPaddingTop;
  late double itemPaddingBottom;
  late EdgeInsets padding;
  late double paddingLeft;
  late double paddingRight;
  late double childWidth; // MenuBox的宽度
  late MediaQueryData mediaQuery; // 获取屏幕尺寸信息
  late double appTopPadding; // 获取刘海的顶部安全区域
  late double mediaWidth; // 获取屏幕宽度
  late double mediaHeight; // 获取屏幕高度
  late double marginAppBottomHeight;
  late double childHeight; // MenuBox的ListView的高度
  late double maxChildHeight; // MenuBox的ListView的最大高度
  late Offset bottomCenterPosition; // 局部坐标 获取当前组件的 x 轴中点
  late Offset localBottomCenterPosition;
  // 设置菜单列表的开始始位置
  late double leftPoint;
  late double rightPoint;
  late double topPoint;
  late double bottomPoint;

  @override
  void initState() {
    super.initState();
    overlayState = Overlay.of(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void controlMenuBox() {
    if (!_isOpen) {
      showMenuBox();
    } else {
      closeMenuBox();
    }
  }

  void closeMenuBox() {
    if (overlayState != null) {
      entry?.remove();
      setState(() {
        _isOpen = false;
      });
    }
  }

  void prepareData() {
    renderBox = context.findRenderObject() as RenderBox;

    length = widget.child.length;
    width = widget.itemWidth;
    height = widget.itemHeight;

    itemMargin = widget.itemMargin;
    itemMarginLeft = itemMargin.left;
    itemMarginRight = itemMargin.right;
    itemMarginTop = itemMargin.top;
    itemMarginBottom = itemMargin.bottom;

    EdgeInsets itemPadding = widget.itemPadding;
    itemPaddingLeft = itemPadding.left;
    itemPaddingRight = itemPadding.right;
    itemPaddingTop = itemPadding.top;
    itemPaddingBottom = itemPadding.bottom;

    padding = widget.padding;
    paddingLeft = padding.left;
    paddingRight = padding.right;

    childWidth = width +
        itemMarginLeft +
        itemMarginRight +
        itemPaddingLeft +
        itemPaddingRight +
        paddingLeft +
        paddingRight;

    mediaQuery = MediaQuery.of(context);
    appTopPadding = mediaQuery.padding.top;
    mediaWidth = mediaQuery.size.width;
    mediaHeight = mediaQuery.size.height;
    marginAppBottomHeight = kBottomNavigationBarHeight + 260.0;

    childHeight = double.parse(length.toString()) * height +
        itemMarginTop +
        itemMarginBottom +
        itemPaddingTop +
        itemPaddingBottom;
    maxChildHeight = mediaHeight - appTopPadding - marginAppBottomHeight;

    bottomCenterPosition = renderBox!.size.bottomCenter(Offset.zero);

    localBottomCenterPosition = renderBox!.localToGlobal(bottomCenterPosition);

    leftPoint = localBottomCenterPosition.dx - childWidth / 2;
    rightPoint = mediaWidth - (localBottomCenterPosition.dx + childWidth / 2);
    topPoint = widget.offsetStartTop > 0.0
        ? widget.offsetStartTop
        : localBottomCenterPosition.dy;
    bottomPoint = kBottomNavigationBarHeight + 42;
  }

  void showMenuBox() {
    prepareData();
    if (overlayState != null && widget.child.isNotEmpty) {
      setState(() {
        _isOpen = true;
      });
      // 创建弹出菜单 OverlayEntry遮罩层入口
      entry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: [
              GestureDetector(onTap: closeMenuBox),
              Positioned(
                top: topPoint,
                bottom: bottomPoint,
                left: leftPoint,
                right: rightPoint,
                child: Container(
                  width: childWidth,
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffbe7634), // 渐变色起始颜色
                        Color(0xfff4e8df), // 渐变色结束颜色
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: childHeight < maxChildHeight
                            ? childHeight
                            : maxChildHeight,
                        child: ListView(
                          padding: const EdgeInsets.all(0.0),
                          children: [
                            MenuItemBuilder(
                              list: widget.child,
                              width: widget.itemWidth,
                              height: widget.itemHeight,
                              margin: widget.itemMargin,
                              padding: widget.itemPadding,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0, width: childWidth),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
      // 将弹出菜单添加到 Overlay 中
      overlayState?.insert(entry!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controlMenuBox,
      icon: widget.icon,
    );
  }
}

class MenuItemBuilder extends StatefulWidget {
  final List<MenuItemData> list;
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final void Function(String)? onMenuItemTap;
  const MenuItemBuilder({
    super.key,
    required this.list,
    required this.width,
    required this.height,
    required this.margin,
    required this.padding,
    this.onMenuItemTap,
  });

  @override
  State<MenuItemBuilder> createState() => _MenuItemBuilderState();
}

class _MenuItemBuilderState extends State<MenuItemBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list.map((item) {
        return GestureDetector(
          onTap: () {
            // widget.onMenuItemTap(item.iconSrc); // 在点击时调用回调函数
            print("点击了${item.value}");
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            padding: widget.padding,
            child: Image.asset(
              item.iconSrc,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MenuItemData {
  final String value;
  final String iconSrc;

  const MenuItemData({
    required this.value,
    required this.iconSrc,
  });
}
