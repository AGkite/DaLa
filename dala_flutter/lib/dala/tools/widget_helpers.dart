import 'package:flutter/material.dart';

double _getWidgetsHeight(GlobalKey key) {
  final RenderObject? renderObject = key.currentContext?.findRenderObject();
  final RenderBox? renderBox = renderObject as RenderBox?;
  if (renderBox != null) {
    return renderBox.size.height; // 返回组件的高度
  }
  return 0.0; // 默认返回值
}

double _getWidgetsWidth(GlobalKey key) {
  final RenderObject? renderObject = key.currentContext?.findRenderObject();
  final RenderBox? renderBox = renderObject as RenderBox?;
  if (renderBox != null) {
    return renderBox.size.width; // 返回组件的宽度
  }
  return 0.0; // 默认返回值
}
