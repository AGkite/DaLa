// 自定义顶部appBar
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    // 让title居左
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(title,style: TextStyle(fontSize: 18),),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}