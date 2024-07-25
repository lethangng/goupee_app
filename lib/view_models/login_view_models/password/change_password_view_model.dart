import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/login_models/form_data.dart';
import '../../../models/login_models/request_data.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/validate.dart';

class ChangePasswordViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError().obs;

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<ApiResponse<bool>> changePasswordRes =
      ApiResponse<bool>.completed(null).obs;

  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;
  final RxBool showNewPassword = false.obs;

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void handleShowNewPassword() {
    showNewPassword.value = !showNewPassword.value;
  }

  void handleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void setChangePassRes(ApiResponse<bool> res) {
    changePasswordRes.value = res;
  }

  void validate(
    String password,
    String confirmPassword,
    String newPassword,
  ) {
    if (password.isEmpty) {
      formError.value.password = 'Mật khẩu không được để trống';
    } else if (!Validate.validatePassword(password)) {
      formError.value.password = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else {
      formError.value.password = '';
    }

    if (newPassword.isEmpty) {
      formError.value.newPassword = 'Mật khẩu không được để trống';
    } else if (!Validate.validatePassword(newPassword)) {
      formError.value.newPassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else {
      formError.value.newPassword = '';
    }

    if (confirmPassword.isEmpty) {
      formError.value.confirmPassword = 'Mật khẩu không được để trống';
    } else if (newPassword != confirmPassword) {
      formError.value.confirmPassword =
          'Mật khẩu nhập lại không khớp, vui lòng nhập lại!';
    } else {
      formError.value.confirmPassword = '';
    }

    formError.refresh();

    if (formError.value == FormDataError()) {
      handleLoad(password, newPassword);
    }
  }

  Future<void> _fetchData(RequestData req) async {
    try {
      await _accessServerRepository.postData(req.toMap());

      setChangePassRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        'Cập nhập thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        // backgroundColor: const Color(0xFF312E2E),
      );
    } catch (e, s) {
      s.printError();
      setChangePassRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleLoad(
    String oldPassword,
    String newPassword,
  ) async {
    Map data = {
      'old_password': oldPassword,
      'new_password': newPassword,
    };

    RequestData resquestData = RequestData(
      query: 'user_change_pass',
      data: json.encode(data),
    );

    await _fetchData(resquestData);
  }
}
