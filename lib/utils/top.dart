import 'package:get/get.dart';

import '../view_models/controllers/app_data_controller.dart';

class Top {
  static final AppDataController _appDataController =
      Get.find<AppDataController>();

  static int? checkTopExam(int examId) {
    // final List<int> listData = _appDataController.appData!.top_exams;
    final List<int> listData =
        _appDataController.appDataRes.value.data!.top_exams;
    if (listData.contains(examId)) {
      return listData.indexOf(examId) + 1;
    }
    return null;
  }
}
