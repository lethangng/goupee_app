// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/login_view_models/login/login2_view_model.dart';
import '../../widgets/button_login_with.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/text_input_container.dart';

class Login2Screen extends StatelessWidget {
  Login2Screen({super.key});
  final Login2ViewModel login2viewModel = Get.put(Login2ViewModel());
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final heightStatusBar = MediaQuery.of(context).viewPadding.top;
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: heightStatusBar + size.height * 0.05,
          ),
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
            'Chào mừng Giang',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Visibility(
            maintainSize: false,
            visible: login2viewModel.argumentData == LoginType.username,
            child: loginWithUsername(),
          ),
          Visibility(
            maintainSize: false,
            visible: login2viewModel.argumentData == LoginType.facebook,
            child: ButtonLoginWith(
              title: 'Sign in with Facebook',
              icon: 'assets/icons/facebook.svg',
              backgroundColor: const Color(0xFF1877F2),
              forColor: const Color(0xFFFFFFFF),
              event: () {
                // facebookLoginViewModel.login();
              },
            ),
          ),
          Visibility(
            maintainSize: false,
            visible: login2viewModel.argumentData == LoginType.google,
            child: ButtonLoginWith(
              title: 'Sign in with Google',
              icon: 'assets/icons/google.svg',
              backgroundColor: Colors.white,
              forColor: const Color(0xFF757575),
              event: () {
                // googleLoginViewModel.login();
              },
            ),
          ),
          Visibility(
            maintainSize: false,
            visible: login2viewModel.argumentData == LoginType.tictok,
            child: ButtonLoginWith(
              title: 'Sign in with TikTok',
              icon: 'assets/icons/tiktok.svg',
              backgroundColor: Colors.white,
              forColor: Colors.black,
              event: () {
                //
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Align(
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.signup);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                'Đăng nhập tài khoản khác',
                style: TextThemes.text14_600
                    .copyWith(color: const Color(0xFFFF6E47)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginWithUsername() {
    return Column(
      children: [
        const Text(
          'Nhập mật khẩu để đăng nhập',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorApp.colorGrey,
          ),
        ),
        const SizedBox(height: 34),
        Obx(
          () => TextInputContainer(
            controller: passwordController,
            label: 'Mật khẩu',
            textHint: '*****',
            requiredValue: true,
            error: login2viewModel.formError.value.password.isNotEmpty,
            errorText: login2viewModel.formError.value.password,
            isPassword: !login2viewModel.showPassword.value,
            event: login2viewModel.handleShowPassword,
            icon: SvgPicture.asset(
              login2viewModel.showPassword.value
                  ? 'assets/icons/eye_fill_icon.svg'
                  : 'assets/icons/eye_slash_fill_icon.svg',
              width: Get.width * 0.06,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                ColorApp.colorGrey5,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        // const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Get.toNamed(Routes.forgotPassword);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              'Quên mật khẩu?',
              style: TextStyle(
                color: ColorApp.colorPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: ColorApp.colorOrange,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: TextButton(
            onPressed: () {
              login2viewModel.validate(
                passwordController.text,
              );
            },
            child: const Text(
              'Đăng nhập',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
