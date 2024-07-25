import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../database/tables/token_table.dart';
import '../../../models/login_models/form_data.dart';
import '../../../models/login_models/login_data.dart';
import '../../../models/login_models/request_data.dart';
import '../../../models/table/token.dart';
import '../../../models/table/user.dart';
import '../../../services/repository/access_server_repository.dart';
import '../../../services/response/api_response.dart';
import '../../../utils/validate.dart';
import '../../controllers/app_data_controller.dart';
import '../../controllers/user_controller.dart';

class LoginViewModel extends GetxController {
  final UserController _userController = Get.find<UserController>();
  final AppDataController _appDataController = Get.find<AppDataController>();
  final Rx<FormDataError> formError = FormDataError().obs;

  final RxBool showPassword = false.obs;
  final Rx<ApiResponse<Map<String, dynamic>>> tokenLoginRes =
      ApiResponse<Map<String, dynamic>>.completed(null).obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setTokenLogin(ApiResponse<Map<String, dynamic>> res) {
    tokenLoginRes.value = res;
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

      printInfo(info: user.toString());

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

      // Tới màn hình Home
      Get.offAllNamed(Routes.home);
    } catch (e) {
      formError.value.email = 'Tài khoản hoặc mật khẩu không đúng';
      formError.value.password = 'Tài khoản hoặc mật khẩu không đúng';
      formError.refresh();
      setTokenLogin(ApiResponse.completed(null));
    }
  }

  Future<void> _handleLogin(LoginData loginData) async {
    RequestData resquestData = RequestData(
      query: 'login_acc',
      data: loginData.toJson(),
    );

    await _fetchTokenLogin(resquestData);
  }

  void handleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void validate(String username, String password) {
    if (username.isEmpty) {
      formError.value.email = 'Tên đăng nhập không được để trống';
    } else if (username.isEmail) {
      formError.value.email = '';
    } else if (Validate.validateVNPhone(username)) {
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

    formError.refresh();

    if (formError.value == FormDataError()) {
      LoginData loginData = LoginData(
        username: username,
        password: password,
      );
      _handleLogin(loginData);
    }
  }
}
