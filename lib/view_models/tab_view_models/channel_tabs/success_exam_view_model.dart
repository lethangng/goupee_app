import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question_model.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../views/widgets/button_primary.dart';
import '../../../views/widgets/show_dialog_error.dart';
import 'on_thi_view_model.dart';

class SuccessExamViewModel extends GetxController {
  final OnThiViewModel _onThiViewModel = Get.find<OnThiViewModel>();
  int countTrue = 0;
  int length = 0;

  void handleCountTrue() {
    length = _onThiViewModel.listDataQuestion.length;
    for (var item in _onThiViewModel.listDataQuestion) {
      if (item.status.value == AnswerStatus.success) {
        countTrue++;
      }
    }
  }

  void initDialog() {
    final RxBool isEdit = false.obs;
    int star = 3;
    final TextEditingController textEditingController = TextEditingController();
    Future.delayed(const Duration(seconds: 1), () {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Đánh giá',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFF353542),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                  unratedColor: const Color(0xFF828288),
                  itemBuilder: (context, _) =>
                      SvgPicture.asset('assets/icons/star-danh-gia.svg'),
                  onRatingUpdate: (rating) {
                    // print(rating);
                    star = rating.toInt();
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Nội dung đánh giá',
                style: TextThemes.text14_400.copyWith(
                  color: const Color(0xFFE0E0E6),
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => GestureDetector(
                  onTap: () => isEdit.value = true,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.3,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFF636363),
                          ),
                        ),
                        child: TextField(
                          controller: textEditingController,
                          cursorColor: ColorApp.colorGrey2,
                          style: const TextStyle(color: Colors.white),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            isDense: true, // Cho chu can giua theo chieu doc
                            hintStyle: TextStyle(
                              color: ColorApp.colorGrey2,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isEdit.value == false,
                        child: Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF4E4E61),
                            ),
                            child: const Text(
                              'Hãy để lại lời góp ý cho chúng tớ nhé',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isEdit.value == false,
                        child: Positioned.fill(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (_onThiViewModel.rateRes.value.status == Status.error) {
                  showDialogError(
                    error: _onThiViewModel.rateRes.value.message!,
                  );
                }

                if (_onThiViewModel.rateRes.value.status == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorApp.colorOrange,
                    ),
                  );
                }

                return ButtonPrimary(
                  title: 'Gửi đánh giá',
                  size: double.infinity,
                  event: () => _onThiViewModel.handleLoadRate(
                    star,
                    textEditingController.text,
                  ),
                );
              }),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF202025),
        isScrollControlled: true,
        // isDismissible: true,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(16),
        // ),
      );
    });
  }

  @override
  void onInit() {
    handleCountTrue();
    initDialog();
    super.onInit();
  }
}
