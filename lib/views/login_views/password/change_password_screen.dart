import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/password/change_password_view_model.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/show_dialog_error.dart';
import '../../widgets/text_input_container.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordViewModel _changePassViewModel =
      Get.put(ChangePasswordViewModel());

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmNewPassController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      title: 'Đổi mật khẩu',
      isBottom: true,
      widget: Column(
        children: [
          SizedBox(
            height: size.height * 0.09,
          ),
          Obx(
            () => TextInputContainer(
              controller: _passController,
              label: 'Nhập mật khẩu hiện tại',
              textHint: '*****',
              requiredValue: false,
              error: _changePassViewModel.formError.value.password.isNotEmpty,
              errorText: _changePassViewModel.formError.value.password,
              isPassword: !_changePassViewModel.showPassword.value,
              event: _changePassViewModel.handleShowPassword,
              icon: SvgPicture.asset(
                _changePassViewModel.showPassword.value
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
              controller: _newPassController,
              label: 'Nhập mật khẩu mới',
              textHint: '*****',
              requiredValue: false,
              error:
                  _changePassViewModel.formError.value.newPassword.isNotEmpty,
              errorText: _changePassViewModel.formError.value.newPassword,
              isPassword: !_changePassViewModel.showNewPassword.value,
              event: _changePassViewModel.handleShowNewPassword,
              icon: SvgPicture.asset(
                _changePassViewModel.showNewPassword.value
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
              controller: _confirmNewPassController,
              label: 'Nhập lại mật khẩu mới',
              textHint: '*****',
              requiredValue: false,
              error: _changePassViewModel
                  .formError.value.confirmPassword.isNotEmpty,
              errorText: _changePassViewModel.formError.value.confirmPassword,
              isPassword: !_changePassViewModel.showConfirmPassword.value,
              event: _changePassViewModel.handleShowConfirmPassword,
              icon: SvgPicture.asset(
                _changePassViewModel.showConfirmPassword.value
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
          Obx(() {
            if (_changePassViewModel.changePasswordRes.value.status ==
                Status.error) {
              showDialogError(
                error: _changePassViewModel.changePasswordRes.value.message!,
              );
            }

            if (_changePassViewModel.changePasswordRes.value.status ==
                Status.loading) {
              return const CircularProgressIndicator(
                color: ColorApp.colorOrange,
              );
            }

            return ButtonPrimary(
              title: 'Xác nhận',
              event: () {
                _changePassViewModel.validate(
                  _passController.text,
                  _confirmNewPassController.text,
                  _newPassController.text,
                );
              },
            );
          }),

          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //       color: ColorApp.colorOrange,
          //       borderRadius: BorderRadius.all(Radius.circular(4))),
          //   child: TextButton(
          //     onPressed: ,
          //     child: const Text(
          //       'Xác nhận',
          //       style: TextStyle(
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
