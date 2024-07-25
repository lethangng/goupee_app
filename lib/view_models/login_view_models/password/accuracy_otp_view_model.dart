import 'dart:async';
import 'package:get/get.dart';

class AccuracyOTPViewModel extends GetxController {
  RxInt remainingTime = (60 * 5).obs; // Thời gian còn lại (giây)
  RxInt minutes = 0.obs; // Phút
  RxInt seconds = 0.obs; // Giây

  RxBool showIndicator = false.obs;
  RxString email = 'webi.@gmail.com'.obs;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void handleShowIndicator(bool value) {
    showIndicator.value = value;
  }

  void handleEmail(String value) {
    email.value = value;
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
        minutes.value = remainingTime.value ~/ 60; // Tính phút
        seconds.value = remainingTime.value % 60; // Tính giây
      } else {
        timer.cancel(); // Dừng timer khi thời gian còn lại đạt 0
      }
    });
  }
}
