import 'package:dala_flutter/dala/db/hi_cache.dart';
import 'package:dala_flutter/dala/pages/login_page.dart';
import 'package:dala_flutter/dala/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import './dala/pages/tabs.dart';
import "./dala/routers/routers.dart";

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://6d203853789df690762c54c65a3ead47@o4507203210379264.ingest.us.sentry.io/4507203213918208';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 去除右上角debug标签条
      title: '搭拉客户端',
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // 去除按钮点击水波纹 全局设置
        splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
        highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
        useMaterial3: true,
      ),
      home: const Tabs(),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
      // home: LoginPage(),
      // home: RegistrationPage(onJumpToLogin: () {  },)
    );
  }
}
