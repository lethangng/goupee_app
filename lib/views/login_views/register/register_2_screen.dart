import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/register/register_2_view_model.dart';
// import '../../view_models/network_controller.dart';
// import '../../widgets/button_login_with.dart';
import '../../widgets/screen_container.dart';
// import '../../view_models/sign_in/facebook_login_view_model.dart';
// import '../../view_models/sign_in/google_login_view_model.dart';

class Resgiter2Screen extends StatelessWidget {
  Resgiter2Screen({super.key});
  final Register2ViewModel register2viewModel = Get.put(Register2ViewModel());
  // final GoogleLoginViewModel googleLoginViewModel =
  //     Get.put(GoogleLoginViewModel());
  // final FacebookLoginViewModel facebookLoginViewModel =
  //     Get.put(FacebookLoginViewModel());

  // final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/signup_image.svg',
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          const Text(
            'Đăng ký tài khoản',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          const Text(
            'Chào mừng bạn đến với GoupeeAI',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.colorGrey,
            ),
          ),
          const SizedBox(height: 34),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn là thành viên mới?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.register),
                child: const Text(
                  ' Tạo tài khoản',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFF6E47),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 34),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFFC1C1CD),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Hoặc đăng ký bằng',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFE0E0E6),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFFC1C1CD),
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          // ButtonLoginWith(
          //   title: 'Sign in with Facebook',
          //   icon: 'assets/icons/facebook.svg',
          //   backgroundColor: const Color(0xFF1877F2),
          //   forColor: const Color(0xFFFFFFFF),
          //   event: () {
          //     // facebookLoginViewModel.login();
          //   },
          // ),
          // const SizedBox(height: 12),
          // ButtonLoginWith(
          //   title: 'Sign in with Google',
          //   icon: 'assets/icons/google.svg',
          //   backgroundColor: Colors.white,
          //   forColor: const Color(0xFF757575),
          //   event: () {
          //     // googleLoginViewModel.login();
          //   },
          // ),
          // const SizedBox(height: 12),
          // ButtonLoginWith(
          //   title: 'Sign in with TikTok',
          //   icon: 'assets/icons/tiktok.svg',
          //   backgroundColor: Colors.white,
          //   forColor: Colors.black,
          //   event: () => register2viewModel.signIn(),
          // ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: ColorApp.colorBlack2,
    //   body: Obx(
    //     () => !networkController.isConnected.value
    //         ? const Center(child: CircularProgressIndicator())
    //         : SingleChildScrollView(
    //             child: Container(
    //               width: double.infinity,
    //               padding: const EdgeInsets.symmetric(horizontal: 15),
    //               child: ,
    //             ),
    //           ),
    //   ),
    // );
  }
}
