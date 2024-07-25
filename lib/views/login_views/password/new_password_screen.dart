import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/password/accuracy_otp_view_model.dart';
import '../../../view_models/login_view_models/password/new_password_view_model.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/text_input_container.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});
  final NewPasswordViewModel newPasswordViewModel =
      Get.put(NewPasswordViewModel());
  final AccuracyOTPViewModel accuracyOTPViewModel =
      Get.find<AccuracyOTPViewModel>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      title: 'Nhập mật khẩu mới',
      widget: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Obx(
            () => TextInputContainer(
              controller: passwordController,
              label: 'Mật khẩu',
              textHint: '*****',
              requiredValue: true,
              error: newPasswordViewModel.formError.value.password.isNotEmpty,
              errorText: newPasswordViewModel.formError.value.password,
              isPassword: !newPasswordViewModel.showPassword.value,
              event: newPasswordViewModel.handleShowPassword,
              icon: SvgPicture.asset(
                newPasswordViewModel.showPassword.value
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
          SizedBox(
            height: size.height * 0.025,
          ),
          Obx(
            () => TextInputContainer(
              controller: confirmPasswordController,
              label: 'Nhập lại mật khẩu mới',
              textHint: '*****',
              requiredValue: true,
              error: newPasswordViewModel
                  .formError.value.confirmPassword.isNotEmpty,
              errorText: newPasswordViewModel.formError.value.confirmPassword,
              isPassword: !newPasswordViewModel.showConfirmPassword.value,
              event: newPasswordViewModel.handleShowConfirmPassword,
              icon: SvgPicture.asset(
                newPasswordViewModel.showConfirmPassword.value
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
                newPasswordViewModel.validate(
                    passwordController.text, confirmPasswordController.text);
                // Get.toNamed(Routes.accuracyOTP);
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
          SizedBox(
            height: size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
