import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/password/forgot_password_view_model.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/text_input_container.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordViewModel _forgotPasswordViewModel =
      Get.put(ForgotPasswordViewModel());
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      title: 'Quên mật khẩu',
      widget: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          Center(
            child: Image.asset(
              'assets/images/sad.png',
              height: size.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const Text(
            'Quên mật khẩu?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          const Center(
            child: Text(
              'Đừng lo lắng, Nhập email bạn đã đăng ký và chúng tôi sẽ gửi cho bạn một mã xác nhận để đặt lại mật khẩu của bạn.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorApp.colorGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.height * 0.035,
          ),
          Obx(
            () => TextInputContainer(
              controller: emailController,
              label: 'Nhập email',
              textHint: 'Nhập email',
              requiredValue: false,
              error: _forgotPasswordViewModel.formError.value.email.isNotEmpty,
              errorText: _forgotPasswordViewModel.formError.value.email,
              event: () {},
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: ColorApp.colorOrange,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: TextButton(
              onPressed: () {
                _forgotPasswordViewModel.validate(emailController.text);
              },
              child: const Text(
                'Tiếp tục',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
