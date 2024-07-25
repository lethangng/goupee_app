import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
// import '../../../utils/text_themes.dart';
// import '../../../view_models/controllers/app_data_controller.dart';
import '../../../view_models/login_view_models/splash/splash_view_model.dart';
// import '../../../view_models/controllers/user_controller.dart';
// import '../../widgets/button_primary.dart';
import '../../widgets/show_dialog_error.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashViewModel _splashViewModel = Get.put(SplashViewModel());
  // final UserController _userController = Get.find<UserController>();
  // final AppDataController _appDataController = Get.find<AppDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack2,
      body: Obx(() {
        if (_splashViewModel.appIdResponse.value.status == Status.error) {
          showDialogError(error: _splashViewModel.appIdResponse.value.message!);
        }

        if (_splashViewModel.userController.userRes.value.status ==
            Status.error) {
          showDialogError(
              error: _splashViewModel.userController.userRes.value.message!);
        }

        if (_splashViewModel.appDataController.appDataRes.value.status ==
            Status.error) {
          showDialogError(
              error:
                  _splashViewModel.appDataController.appDataRes.value.message!);
        }

        // if (_splashViewModel.myLinhVatTabViewModel.linhVatRes.value.status ==
        //     Status.error) {
        //   showDialogError(
        //       error: _splashViewModel
        //           .myLinhVatTabViewModel.linhVatRes.value.message!);
        // }

        if (_splashViewModel.appIdResponse.value.status == Status.completed &&
            _splashViewModel.userController.userRes.value.status ==
                Status.completed &&
            _splashViewModel.appDataController.appDataRes.value.status ==
                Status.completed) {
          _splashViewModel.goToScreen();
        }

        return loading();
      }),
    );
  }

  // void showDialogError({required String error}) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Get.dialog(
  //       barrierDismissible: false,
  //       Center(
  //         child: Container(
  //           width: Get.width * 0.8,
  //           decoration: const BoxDecoration(
  //             color: Color(0xFF202025),
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(20),
  //             ),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Material(
  //               color: Colors.transparent,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     'Có lỗi rồi!',
  //                     style: TextThemes.text16_600,
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Center(
  //                     child: Image.asset(
  //                       'assets/images/sad.png',
  //                       height: Get.height * 0.25,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   Text(
  //                     error,
  //                     textAlign: TextAlign.center,
  //                     style: TextThemes.text16_600,
  //                   ),
  //                   const SizedBox(height: 16),
  //                   ButtonPrimary(
  //                     title: 'Thử lại',
  //                     event: () {
  //                       Get.back();
  //                       Future.delayed(const Duration(seconds: 1), () {
  //                         _splashViewModel.fetchDataAppId();
  //                       });
  //                     },
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  Center loading() {
    return Center(
      child: Image.asset(
        'assets/images/splash_image.png',
        width: Get.width * 0.5,
        fit: BoxFit.cover,
      ),
    );
  }
}
