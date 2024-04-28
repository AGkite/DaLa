import 'package:dala_flutter/dala/db/hi_cache.dart';
import 'package:dala_flutter/dala/pages/login_page.dart';
import 'package:dala_flutter/dala/pages/registration_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      title: '搭拉客户端',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      // home: RegistrationPage(onJumpToLogin: () {  },)
    );
  }
}
