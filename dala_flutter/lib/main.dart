import 'package:dala_flutter/dala/db/hi_cache.dart';
import 'package:dala_flutter/dala/pages/login_page.dart';
import 'package:dala_flutter/dala/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://6d203853789df690762c54c65a3ead47@o4507203210379264.ingest.us.sentry.io/4507203213918208';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      title: '搭拉客户端',
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
      // home: RegistrationPage(onJumpToLogin: () {  },)
    );
  }
}

