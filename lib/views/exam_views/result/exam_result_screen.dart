import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app/routes.dart';
import '../../../models/Exam/exam_history.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/thi_thu/result_screen_view_model.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/screen_container.dart';
import '../../widgets/show_dialog_error.dart';

class ExamResultScreen extends StatelessWidget {
  ExamResultScreen({super.key});
  final ResultScreenViewModel _resultScreenViewModel =
      Get.put(ResultScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
      title: 'Kết quả bài thi',
      widget: Obx(() {
        if (_resultScreenViewModel.questionRes.value.status == Status.error) {
          showDialogError(
            error: _resultScreenViewModel.questionRes.value.message!,
          );
        }

        if (_resultScreenViewModel.questionRes.value.status ==
            Status.completed) {
          return screen();
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorApp.colorOrange,
          ),
        );
      }),
    );
  }

  Widget screen() {
    final ExamHistory examHistoryEdit = _resultScreenViewModel.examHistoryEdit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/exam.png',
              width: Get.width,
            ),
            Column(
              children: [
                const SizedBox(height: 46),
                SvgPicture.asset('assets/images/success.svg'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 38),
        Text(
          'Chúc mừng bạn đã hoàn thành đề thi',
          style: TextThemes.text16_600.copyWith(
            color: const Color(0xFF2EE56B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Đây là kết quả bài kiểm tra của bạn.',
          style: TextThemes.text14_400.copyWith(
            color: const Color(0xFFE0E0E6),
          ),
        ),
        Text(
          'Bạn thật xuất sắc!',
          style: TextThemes.text14_400.copyWith(
            color: const Color(0xFFE0E0E6),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: '${examHistoryEdit.total_true}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2EE56B),
            ),
            children: [
              const TextSpan(
                text: '/',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: '${examHistoryEdit.total_question}',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        rowInfo(
          title: 'Tổng số câu hỏi:',
          value: '${examHistoryEdit.total_question} câu',
          widthSize: Get.width * 0.8,
        ),
        rowInfo(
          title: 'Số câu trả lời đúng:',
          value: '${examHistoryEdit.total_true} câu',
          widthSize: Get.width * 0.8,
          isTrue: true,
        ),
        rowInfo(
          title: 'Thời gian bạn làm bài:',
          value: examHistoryEdit.total_time_txt,
          widthSize: Get.width * 0.8,
        ),
        const SizedBox(height: 44),
        ButtonPrimary(
          title: 'Kết quả chi tiết',
          event: () => Get.toNamed(Routes.result),
          size: Get.width * 0.78,
        ),
        const SizedBox(height: 12),
        ButtonPrimary(
          title: 'Làm lại',
          event: () => Get.offNamed(
            Routes.thiThu,
            arguments: {
              // 'examHistoryId': examHistory.id,
              // 'examId': examHistory.exam_id,
              // 'totalQuestion': examHistory.total_question,
              'examHistoryId': examHistoryEdit.id,
              'examId': examHistoryEdit.exam_id,
              'totalQuestion': examHistoryEdit.total_question,
            },
          ),
          size: Get.width * 0.78,
        ),
        const SizedBox(height: 12),
        ButtonPrimary(
          title: 'Về trang chủ',
          event: () => Get.offAllNamed(Routes.home),
          background: const Color(0xFF312E2E),
          size: Get.width * 0.78,
        ),
        const SizedBox(height: 31),
      ],
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
    required double widthSize,
    bool? isTrue,
  }) {
    return Container(
      width: widthSize,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextThemes.text14_400,
          ),
          Text(
            value,
            style: TextThemes.text14_600.copyWith(
              color: (isTrue != null && isTrue)
                  ? const Color(0xFF2EE56B)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
