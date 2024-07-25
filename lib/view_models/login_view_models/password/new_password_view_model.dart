import 'package:get/get.dart';

import '../../../models/login_models/form_data.dart';
import '../../../utils/validate.dart';

class NewPasswordViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError().obs;

  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void handleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void validate(
    String password,
    String confirmPassword,
  ) {
    if (password.isEmpty) {
      formError.value.password = 'Mật khẩu không được để trống';
    } else if (!Validate.validatePassword(password)) {
      formError.value.password = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else {
      formError.value.password = '';
    }

    if (confirmPassword.isEmpty) {
      formError.value.confirmPassword = 'Mật khẩu không được để trống';
    } else if (password != confirmPassword) {
      formError.value.confirmPassword = 'Nhập lại mật khẩu không đúng';
    } else {
      formError.value.confirmPassword = '';
    }

    formError.refresh();

    if (formError.value == FormDataError()) {
      //
    }
  }
}
