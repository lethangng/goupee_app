import 'package:get/get.dart';

// import '../../models/Exam/question.dart';

class ViewExamViewModel extends GetxController {
  RxInt isSelect = 1.obs;

  void hanleOnSelect(int value) {
    isSelect.value = value;
  }
}
