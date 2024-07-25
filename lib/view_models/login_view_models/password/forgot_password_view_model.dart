import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/login_models/form_data.dart';

class ForgotPasswordViewModel extends GetxController {
  final Rx<FormDataError> formError = FormDataError().obs;

  void validate(String email) {
    if (email.isEmpty) {
      formError.value.email = 'Email không được để trống';
    } else if (!email.isEmail) {
      formError.value.email = 'Vui lòng nhập đúng định dạng email';
    } else {
      formError.value.email = '';
      Get.toNamed(Routes.accuracyOTP);
    }
    formError.refresh();
    if (formError.value == FormDataError()) {
      //
    }
  }
}
