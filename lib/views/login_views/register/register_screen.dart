import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/register/register_view_model.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/show_dialog_error.dart';
import '../../widgets/text_input_container.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final RegisterViewModel _registerViewModel = Get.put(RegisterViewModel());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  // final TextEditingController _idNgGioiThieuController =
  //     TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Tạo tài khoản mới',
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
          SizedBox(
            height: size.height * 0.05,
          ),
          Obx(
            () => TextInputContainer(
              controller: _nameController,
              label: 'Họ và tên *',
              textHint: 'Nhập họ và tên',
              requiredValue: false,
              error: _registerViewModel.formError.value.name.isNotEmpty,
              errorText: _registerViewModel.formError.value.name,
              event: () {},
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          // Obx(
          //   () => TextInputContainer(
          //     controller: emailController,
          //     label: 'Nhập số điện thoại/Email',
          //     textHint: 'Nhập sdt hoặc email',
          //     requiredValue: true,
          //     error: registerViewModel.formError.value.email.isNotEmpty,
          //     errorText: registerViewModel.formError.value.email,
          //     textButton: 'Gửi mã OTP',
          //     event: () {},
          //   ),
          // ),
          Obx(
            () => TextInputContainer(
              controller: _emailController,
              label: 'Nhập số điện thoại/Email',
              textHint: 'Nhập sdt hoặc email',
              requiredValue: true,
              error: _registerViewModel.formError.value.email.isNotEmpty,
              errorText: _registerViewModel.formError.value.email,
              // textButton: _registerViewModel.showOTP.value ? 'Gửi mã OTP' : '',
              focusNode: _registerViewModel.focusNode,
              event: () {},
            ),
          ),
          // Visibility(
          //   visible: _registerViewModel.showOTP.value,
          //   maintainSize: false,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: size.height * 0.025,
          //       ),
          //       Obx(
          //         () => TextInputContainer(
          //           controller: otpController,
          //           label: 'Mã OTP',
          //           textHint: 'Nhập mã OTP',
          //           requiredValue: true,
          //           error: _registerViewModel.formError.value.otp.isNotEmpty,
          //           errorText: _registerViewModel.formError.value.otp,
          //           // errorText: 'Mã OTP vừa được gửi đến số điện thoại của bạn',
          //           event: () {},
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          SizedBox(
            height: size.height * 0.025,
          ),
          Obx(
            () => TextInputContainer(
              controller: _passwordController,
              label: 'Mật khẩu',
              textHint: 'Nhập mật khẩu',
              requiredValue: true,
              error: _registerViewModel.formError.value.password.isNotEmpty,
              errorText: _registerViewModel.formError.value.password,
              isPassword: !_registerViewModel.showPassword.value,
              event: _registerViewModel.handleShowPassword,
              icon: SvgPicture.asset(
                _registerViewModel.showPassword.value
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
              controller: _confirmPasswordController,
              label: 'Nhập lại mật khẩu',
              textHint: 'Nhập mật khẩu',
              requiredValue: true,
              error:
                  _registerViewModel.formError.value.confirmPassword.isNotEmpty,
              errorText: _registerViewModel.formError.value.confirmPassword,
              isPassword: !_registerViewModel.showConfirmPassword.value,
              event: _registerViewModel.handleShowConfirmPassword,
              icon: SvgPicture.asset(
                _registerViewModel.showConfirmPassword.value
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
          // SizedBox(
          //   height: size.height * 0.025,
          // ),
          // TextInputContainer(
          //   controller: _idNgGioiThieuController,
          //   label: 'ID người giới thiệu',
          //   textHint: 'Nhập ID',
          //   requiredValue: false,
          //   error: false,
          //   focusNode: _registerViewModel.focusNodeNgGioiThieu,
          //   errorText: '',
          //   event: () {},
          // ),
          // Obx(
          //   () => Visibility(
          //     visible: _registerViewModel.showNameNgGioiThieu.isNotEmpty,
          //     maintainSize: false,
          //     child: Column(
          //       children: [
          //         SizedBox(
          //           height: size.height * 0.025,
          //         ),
          //         TextInputContainer(
          //           controller: idNgGioiThieuController,
          //           label: 'Tên người giới thiệu',
          //           textHint: 'Hoàng Văn A',
          //           requiredValue: false,
          //           error: false,
          //           readOnly: true,
          //           errorText: '',
          //           event: () {},
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Bằng việc nhấn vào ',
                  style: TextStyle(
                    height: 1.5,
                    // letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Đăng ký',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ', bạn đã đồng ý với',
                    ),
                    TextSpan(
                      text: '\nĐiều khoản sử dụng',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3098FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Obx(() {
            if (_registerViewModel.registerRes.value.status == Status.error) {
              showDialogError(
                  error: _registerViewModel.registerRes.value.message!);
            }
            // if (_registerViewModel.appDataController.appDataRes.value.status ==
            //     Status.error) {
            //   showDialogError(
            //     error: _registerViewModel
            //         .appDataController.appDataRes.value.message!,
            //   );
            // }
            if (_registerViewModel.registerRes.value.status == Status.loading) {
              return const CircularProgressIndicator(
                color: ColorApp.colorOrange,
              );
            }

            return ButtonPrimary(
              title: 'Đăng ký',
              vertical: 13,
              event: () {
                _registerViewModel.validate(
                  _nameController.text,
                  _emailController.text,
                  _otpController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
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
                'Bạn đã có tài khoản? ',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.signup),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: ColorApp.colorOrange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
