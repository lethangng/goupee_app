import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../database/tables/token_table.dart';
import '../../../models/table/token.dart';
import '../../../services/repository/app_id_repository.dart';
import '../../../services/response/api_response.dart';
import '../../controllers/app_data_controller.dart';
import '../../controllers/user_controller.dart';
// import '../../main_view_models/main_tabs/my_channel_tabs/tabs/my_linh_vat_tab.dart';

class SplashViewModel extends GetxController {
  final AppIdRepository _appIdRepository = AppIdRepository();
  final UserController userController = Get.find<UserController>();
  final AppDataController appDataController = Get.find<AppDataController>();
  // final MyLinhVatTabViewModel myLinhVatTabViewModel =
  //     Get.put(MyLinhVatTabViewModel());

  final Rx<ApiResponse<String>> appIdResponse =
      ApiResponse<String>.loading().obs;

  void setDataAppId(ApiResponse<String> res) {
    appIdResponse.value = res;
  }

  // Call API lay AppId
  Future<void> fetchDataAppId() async {
    try {
      setDataAppId(ApiResponse.loading());
      final String data = await _appIdRepository.getData(null);
      await TokensTable.insert(Token(app_id: data));
      setDataAppId(ApiResponse.completed(data));
    } catch (e, s) {
      s.printError();
      setDataAppId(ApiResponse.error(e.toString()));
    }
  }

  // Khoi tao lay app_id va tokenLogin
  Future<void> initData() async {
    await TokensTable.getToken().then((value) async {
      if (value == null) {
        await fetchDataAppId();
        // userController.setUserRes(ApiResponse.completed(null));
        // appDataController.setAppDataRes(ApiResponse.completed(null));
      } else {
        setDataAppId(ApiResponse.completed(value.app_id));
        // if (value.loginToken != null) {
        //   setTokenLogin(ApiResponse.completed(value.loginToken));
        // }
      }

      await userController.handleGetUser();
      await appDataController.handleGetAppData();
    });
  }

  Future<void> goToScreen() async {
    // Get.offAllNamed(Routes.home);
    await Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.home);
    });
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
