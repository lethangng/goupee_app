import 'package:get/get.dart';

import '../../../models/login_models/form_data.dart';
import '../../../utils/validate.dart';

enum LoginType {
  facebook,
  google,
  tictok,
  username,
}

class Login2ViewModel extends GetxController {
  final argumentData = Get.arguments ?? LoginType.username;

  final Rx<FormDataError> formError = FormDataError(
    name: '',
    email: '',
    otp: '',
    password: '',
    confirmPassword: '',
  ).obs;
  final RxBool showPassword = false.obs;

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void validate(String password) {
    if (password.isEmpty) {
      formError.value.password = 'Mật khẩu không được để trống';
    } else if (!Validate.validatePassword(password)) {
      formError.value.password = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
    } else {
      formError.value.password = '';
    }
    formError.refresh();

    if (formError.value ==
        FormDataError(
          name: '',
          email: '',
          otp: '',
          password: '',
          confirmPassword: '',
        )) {
      // debugPrint('Goi APi');
    }
  }
}
