import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/login_view_models/password/accuracy_otp_view_model.dart';
import '../../widgets/screen_container.dart';

class AccuracyOTPScreen extends StatelessWidget {
  AccuracyOTPScreen({super.key});
  final AccuracyOTPViewModel accuracyOTPViewModel =
      Get.put(AccuracyOTPViewModel());

  final defaultPinTheme = PinTheme(
    width: 45,
    height: 55,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C23),
      border: Border.all(
        width: 1,
        color: ColorApp.colorGrey3,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ScreenContainer(
      title: 'Xác thực OTP',
      widget: Stack(
        children: [
          SizedBox(
            height: size.height,
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.09,
              ),
              const Text(
                'Nhập mã xác nhận',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Chúng tôi gửi mã xác minh cho bạn qua email ${accuracyOTPViewModel.email.value}. Bạn có thể kiểm tra hộp thư của bạn.',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorApp.colorGrey,
                ),
                textAlign: TextAlign.center,
              ),
              Obx(
                () => Text(
                  '0${accuracyOTPViewModel.minutes.value} : ${accuracyOTPViewModel.seconds.value.toString().length == 1 ? ("0${accuracyOTPViewModel.seconds.value}") : accuracyOTPViewModel.seconds.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorApp.colorRed2,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     border: Border.all(
                //       color: Colors.green,
                //     ),
                //   ),
                // ),
                onCompleted: (pin) {
                  accuracyOTPViewModel.handleShowIndicator(true);
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.toNamed(Routes.newPassword);
                  });
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(
                () => Visibility(
                  visible: !accuracyOTPViewModel.showIndicator.value,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Gửi lại OTP',
                      style: TextStyle(
                        color: ColorApp.colorOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: accuracyOTPViewModel.showIndicator.value,
              child: const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(
                    color: ColorApp.colorOrange2,
                    radius: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
