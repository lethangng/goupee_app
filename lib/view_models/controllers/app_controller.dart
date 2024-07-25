import 'package:get/get.dart';

import '../../database/goupee_database.dart';

class AppController extends GetxController {
  Future<void> initData() async {
    await GoupeeDatabase.instance.database;
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
