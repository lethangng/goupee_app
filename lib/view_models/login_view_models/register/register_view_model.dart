import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../database/tables/token_table.dart';
import '../../../models/login_models/form_data.dart';
import '../../../models/login_models/request_data.dart';
import '../../../models/table/token.dart';
import '../../../models/table/user.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/helper.dart';
import '../../../utils/validate.dart';
import '../../controllers/app_data_controller.dart';
import '../../controllers/user_controller.dart';

class RegisterViewModel extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final AppDataController _appDataController = Get.find<AppDataController>();

  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();
  final Rx<ApiResponse<Map<String, dynamic>>> registerRes =
      ApiResponse<Map<String, dynamic>>.completed(null).obs;

  void setTokenLogin(ApiResponse<Map<String, dynamic>> res) {
    registerRes.value = res;
  }

  final Rx<FormDataError> formError = FormDataError().obs;

  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;
  final RxBool showOTP = false.obs;
  final RxString showNameNgGioiThieu = ''.obs;

  final FocusNode focusNode = FocusNode();
  final FocusNode focusNodeNgGioiThieu = FocusNode();

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void handleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  Future<void> validate(
    String name,
    String email,
    String otp,
    String password,
    String confirmPassword,
  ) async {
    if (name.isEmpty) {
      formError.value.name = 'Họ và tên không được để trống';
    } else {
      formError.value.name = '';
    }

    // if (otp.isEmpty) {
    //   formError.value.otp = 'Mã OTP không được để trống';
    // } else {
    //   formError.value.otp = '';
    // }

    // if (email.isEmpty) {
    //   formError.value.email = 'Số điện thoại/Email không được để trống';
    // } else if (!email.isEmail) {
    //   formError.value.email =
    //       'Vui lòng nhập đúng định dạng số điện thoại/email.';
    // } else {
    //   formError.value.email = '';
    // }

    if (email.isEmpty) {
      formError.value.email = 'Tên đăng nhập không được để trống';
    } else if (email.isEmail) {
      formError.value.email = '';
    } else if (Validate.validateVNPhone(email)) {
      formError.value.email = '';
    } else {
      formError.value.email =
          'Vui lòng nhập đúng định dạng số điện thoại/email.';
    }

    if (password.isEmpty) {
      formError.value.password = 'Mật khẩu không được để trống';
    } else if (password.length <= 6) {
      formError.value.password = 'Mật khẩu phải lớn hơn 6 ký tự';
    } else if (!Validate.validatePassword(password)) {
      formError.value.password =
          'Mật khẩu phải gồm ít nhất 1 số, 1 chữ hoa, 1 chữ thường và 1 ký tự đặc biệt';
    } else {
      formError.value.password = '';
    }

    if (confirmPassword.isEmpty) {
      formError.value.confirmPassword = 'Mật khẩu nhập lại không được để trống';
    } else if (password != confirmPassword) {
      formError.value.confirmPassword =
          'Mật khẩu nhập lại không khớp, vui lòng nhập lại!';
    } else {
      formError.value.confirmPassword = '';
    }

    formError.refresh();
    if (formError.value == FormDataError()) {
      RegisterData registerData = RegisterData(
        fullname: name,
        username: email,
        password: password,
        parent_id: '',
      );
      await _handleRegister(registerData);
    }
  }

  // Call API lay tokenLogin
  Future<void> _fetchTokenLogin(RequestData req) async {
    setTokenLogin(ApiResponse.loading());
    try {
      final Map<String, dynamic> data =
          await _accessServerRepository.postData(req.toMap());

      Token? value = await TokensTable.getToken();

      if (value == null || value.app_id.isEmpty) {
        throw Exception('Lỗi không có App id.');
      }

      User user = User.fromMap(data['user_info']);
      user.is_login = 1;

      Token token = Token(
        app_id: value.app_id,
        login_token: data['token'],
        user_id: user.id,
        is_login: 1,
      );

      await TokensTable.update(token: token);
      _userController.setUserRes(ApiResponse.completed(user));
      await _appDataController.handleGetAppData();

      setTokenLogin(ApiResponse.completed(data));
      Get.offAllNamed(Routes.home);
    } catch (e, s) {
      s.printError();
      formError.value.email = Helper.errorMessage(e.toString());
      formError.refresh();
      setTokenLogin(ApiResponse.completed(null));
    }
  }

  Future<void> _handleRegister(RegisterData registerData) async {
    RequestData resquestData = RequestData(
      query: 'register_acc',
      data: registerData.toJson(),
    );

    await _fetchTokenLogin(resquestData);
  }

  void onFocusChange() {
    if (!focusNode.hasFocus) {
      showOTP.value = true;
    }
  }

  void onFocusChangeNgGioiThieu() {
    if (!focusNode.hasFocus) {
      showNameNgGioiThieu.value = 'Hoàng Văn A';
    }
  }

  @override
  void onInit() {
    focusNode.addListener(onFocusChange);
    focusNodeNgGioiThieu.addListener(onFocusChangeNgGioiThieu);
    super.onInit();
  }

  @override
  void onClose() {
    focusNode.removeListener(onFocusChange);
    focusNodeNgGioiThieu.removeListener(onFocusChangeNgGioiThieu);
    super.onClose();
  }
}
