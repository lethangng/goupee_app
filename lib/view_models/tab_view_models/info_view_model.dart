import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../database/tables/token_table.dart';
import '../../models/table/token.dart';

class InfoViewModel extends GetxController {
  Future<void> handleLogout() async {
    await TokensTable.getToken().then((value) async {
      if (value == null) return;
      Token token = Token(
        app_id: value.app_id,
        login_token: value.login_token,
        user_id: value.user_id,
        is_login: null,
      );
      await TokensTable.update(token: token);
      Get.offAllNamed(Routes.signup);
    });
    // Get.toNamed(Routes.signup);
  }
}
