// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question_model.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/thi_thu/result_screen_view_model.dart';
import '../show_dialog_error.dart';
import 'button_result.dart';

class ResultExamContainer extends StatelessWidget {
  ResultExamContainer({
    super.key,
    required this.question,
  });

  final QuestionModel question;
  final ResultScreenViewModel _resultViewModel =
      Get.find<ResultScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    String content = r"""quest""";
    content = content.replaceAll("quest", question.question);
    return Obx(
      () => Column(
        children: [
          TeXView(
            child: TeXViewDocument(
              content,
              style: TeXViewStyle(
                contentColor: Colors.white,
                fontStyle: TeXViewFontStyle(
                  fontSize: 16,
                  fontWeight: TeXViewFontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...question.listAnswer.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ButtonResult(
                answer: item,
                answerStatus: question.status.value,
              ),
            ),
          ),
          Visibility(
            visible: (question.status.value == AnswerStatus.success ||
                question.status.value == AnswerStatus.fail),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Giải thích đáp án',
                      style: TextThemes.text12_500,
                    ),
                    const SizedBox(width: 4),
                    Visibility(
                      visible: !question.unLock.value,
                      child: Image.asset('assets/icons/vuong-mien.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: !question.unLock.value,
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  child: SizedBox(
                    width: Get.width * 0.4,
                    child: FilledButton(
                      onPressed: () => onShowDialogDungDapAnMau(),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF312E2E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Xem đáp án',
                        style: TextThemes.text14_600,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: question.unLock.value,
                  child: Obx(() {
                    if (_resultViewModel.explainRes.value.status ==
                        Status.error) {
                      showDialogError(
                          error: _resultViewModel.explainRes.value.message!);
                    }

                    if (_resultViewModel.explainRes.value.status ==
                        Status.completed) {
                      return containerGiaiThich(
                        title: question.explain['title'],
                        value: question.explain['value'],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorApp.colorOrange,
                      ),
                    );
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget containerGiaiThich({
    required String title,
    required String value,
  }) {
    String titleVal = r"""title""";
    titleVal = titleVal.replaceAll("title", title);
    String valueVal = r"""value""";
    valueVal = valueVal.replaceAll("value", value);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF312E2E),
        border: Border.all(
          width: 1,
          color: const Color(0xFF636363),
        ),
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: const Color(0xFF121212).withOpacity(0.15)),
        //   BoxShadow(
        //     blurRadius: 8,
        //     offset: const Offset(0, 4),
        //     color: const Color(0xFF121212).withOpacity(0.15),
        //   ),
        //   BoxShadow(
        //     blurRadius: 15,
        //     offset: const Offset(0, 15),
        //     color: const Color(0xFF121212).withOpacity(0.13),
        //   ),
        //   BoxShadow(
        //     blurRadius: 20,
        //     offset: const Offset(0, 34),
        //     color: const Color(0xFF121212).withOpacity(0.08),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TeXView(
            child: TeXViewDocument(
              titleVal,
              style: TeXViewStyle(
                contentColor: const Color(0xFF2EE56B),
                fontStyle: TeXViewFontStyle(
                  fontSize: 14,
                  fontWeight: TeXViewFontWeight.w600,
                ),
              ),
            ),
          ),
          // Text(
          //   title,
          //   style: TextThemes.text14_600.copyWith(
          //     color: const Color(0xFF2EE56B),
          //   ),
          // ),
          const SizedBox(height: 8),
          TeXView(
            child: TeXViewDocument(
              valueVal,
              style: TeXViewStyle(
                contentColor: Colors.white,
                fontStyle: TeXViewFontStyle(
                  fontSize: 14,
                  fontWeight: TeXViewFontWeight.w400,
                ),
              ),
            ),
          ),
          // Text(
          //   value,
          //   style: TextThemes.text14_400,
          // ),
        ],
      ),
    );
  }

  void onShowDialogDungDapAnMau() {
    Get.defaultDialog(
      title: 'Dùng đáp án mẫu',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.only(top: 20),
      backgroundColor: const Color(0xFF202025),
      radius: 20,
      content: SizedBox(
        width: Get.width * 0.9,
        child: Column(
          children: [
            button(
              title: 'Giới thiệu bạn bè',
              color: const Color(0xFFFF6E47),
              icon: 'assets/icons/gioi-thieu.svg',
              event: () {},
            ),
            const SizedBox(height: 15),
            button(
              title: 'Xem video',
              color: const Color(0xFFFF6E47),
              icon: 'assets/icons/video.svg',
              event: () {},
            ),
            const SizedBox(height: 15),
            button(
              title: 'Dùng ${question.g_point}G',
              color: const Color(0xFF312E2E),
              icon: 'assets/icons/coin-icon.png',
              event: () {
                Get.back();
                _resultViewModel.handleViewDapAn();
              },
              typeImageSvg: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    required String title,
    required Color color,
    required String icon,
    required event,
    bool? typeImageSvg,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: event,
            style: TextButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (typeImageSvg == null || typeImageSvg)
                    ? SvgPicture.asset(icon)
                    : Image.asset(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
