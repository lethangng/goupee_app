import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
// import 'services/notification_service.dart';
// import 'package:tiktok_login_flutter/tiktok_login_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Xet mau trong suot cho thanh status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  // await TiktokLoginFlutter.initializeTiktokLogin("aw1qwruisdbdfa6u");

  // await NotificationService.initializeNotification();
  runApp(const App());
}
