import 'package:get/get.dart';

class ExportExamSusscessViewModel extends GetxController {
  late final int examId;
  late final String type;
  @override
  void onInit() {
    examId = Get.arguments['examId'];
    type = Get.arguments['type'];
    super.onInit();
  }
}
