import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color_app.dart';
import '../view_models/controllers/controller_bindings.dart';
import '../views/login_views/splash/splash_screen.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      title: 'Goup App',
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: ColorApp.colorBlack2,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: ColorApp.colorGrey2,
        ),
      ),
      unknownRoute: GetPage(
          name: '/notfound',
          page: () =>
              SplashScreen()), // Neu khong tim thay tuyen duong nao hop le no se chay vao day
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
