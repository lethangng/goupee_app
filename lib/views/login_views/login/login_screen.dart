import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/login/login_view_model.dart';
// import '../../../view_models/login_controller/login_controller.dart';
// import '../../widgets/button_login_with.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/show_dialog_error.dart';
import '../../widgets/text_input_container.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginViewModel _loginViewModel = Get.put(LoginViewModel());
  // final LoginController _loginController = Get.find<LoginController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      widget: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'Đăng nhập tài khoản',
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
            'Vui lòng nhập tài khoản của bạn ở đây',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.colorGrey,
            ),
          ),
          const SizedBox(height: 24),
          // ButtonLoginWith(
          //   title: 'Sign in with Facebook',
          //   icon: 'assets/icons/facebook.svg',
          //   backgroundColor: const Color(0xFF1877F2),
          //   forColor: const Color(0xFFFFFFFF),
          //   event: () {
          //     _loginController.loginFacebook();
          //   },
          // ),
          // const SizedBox(height: 12),
          // ButtonLoginWith(
          //   title: 'Sign in with Google',
          //   icon: 'assets/icons/google.svg',
          //   backgroundColor: Colors.white,
          //   forColor: const Color(0xFF757575),
          //   event: () {
          //     _loginController.loginGoogle();
          //   },
          // ),
          // const SizedBox(height: 12),
          // ButtonLoginWith(
          //   title: 'Sign in with TikTok',
          //   icon: 'assets/icons/tiktok.svg',
          //   backgroundColor: Colors.white,
          //   forColor: Colors.black,
          //   event: () {
          //     //
          //   },
          // ),
          // const SizedBox(height: 24),
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
                  'Hoặc đăng nhập bằng',
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
          const SizedBox(height: 24),
          Obx(
            () => TextInputContainer(
              controller: _emailController,
              label: 'Nhập số điện thoại/Email',
              textHint: 'Nhập sdt hoặc email',
              requiredValue: false,
              error: _loginViewModel.formError.value.email.isNotEmpty,
              errorText: _loginViewModel.formError.value.email,
              event: () {},
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Obx(
            () => TextInputContainer(
              controller: _passwordController,
              label: 'Mật khẩu',
              textHint: '*****',
              requiredValue: false,
              error: _loginViewModel.formError.value.password.isNotEmpty,
              errorText: _loginViewModel.formError.value.password,
              isPassword: !_loginViewModel.showPassword.value,
              event: _loginViewModel.handleShowPassword,
              icon: SvgPicture.asset(
                _loginViewModel.showPassword.value
                    ? 'assets/icons/eye_fill_icon.svg'
                    : 'assets/icons/eye_slash_fill_icon.svg',
                width: size.width * 0.06,
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  ColorApp.colorGrey5,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.toNamed(Routes.forgotPassword),
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
          Obx(() {
            if (_loginViewModel.tokenLoginRes.value.status == Status.error) {
              showDialogError(
                error: _loginViewModel.tokenLoginRes.value.message!,
              );
            }

            // if (_loginViewModel.appDataController.appDataRes.value.status ==
            //     Status.error) {
            //   showDialogError(
            //     error:
            //         _loginViewModel.appDataController.appDataRes.value.message!,
            //   );
            // }

            // if (_loginViewModel.tokenLoginRes.value.status == Status.loading &&
            //     _loginViewModel.userController.userRes.value.status ==
            //         Status.loading &&
            //     _loginViewModel.appDataController.appDataRes.value.status ==
            //         Status.loading) {
            //   return const CircularProgressIndicator(
            //     color: ColorApp.colorOrange,
            //   );
            // }

            if (_loginViewModel.tokenLoginRes.value.status == Status.loading) {
              return const CircularProgressIndicator(
                color: ColorApp.colorOrange,
              );
            }

            return ButtonPrimary(
              title: 'Đăng nhập',
              vertical: 13,
              event: () {
                _loginViewModel.validate(
                  _emailController.text,
                  _passwordController.text,
                );
              },
            );
          }),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn chưa có tài khoản?',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.register2);
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: ColorApp.colorOrange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
