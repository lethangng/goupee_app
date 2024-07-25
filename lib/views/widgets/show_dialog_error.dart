import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../../utils/color_app.dart';
import '../../utils/helper.dart';
import '../../utils/text_themes.dart';
// import 'button_primary.dart';

void showDialogError({
  required String error,
  Future<void> Function()? event,
}) {
  // final RxBool isLoading = false.obs;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: const BoxDecoration(
            color: Color(0xFF202025),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/close.svg',
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Có lỗi rồi!',
                  //   style: TextThemes.text16_600,
                  // ),
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/images/sad.png',
                      height: Get.height * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Helper.errorMessage(error),
                    textAlign: TextAlign.center,
                    style: TextThemes.text16_600,
                  ),
                  // const SizedBox(height: 16),
                  // event != null
                  //     ? Obx(() {
                  //         if (isLoading.value) {
                  //           return const Center(
                  //             child: CircularProgressIndicator(
                  //               color: ColorApp.colorOrange,
                  //             ),
                  //           );
                  //         } else {
                  //           return ButtonPrimary(
                  //             title: 'Thử lại',
                  //             event: () async {
                  //               isLoading.value = true;
                  //               await event();
                  //               Get.back();
                  //             },
                  //           );
                  //         }
                  //       })
                  //     : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}
