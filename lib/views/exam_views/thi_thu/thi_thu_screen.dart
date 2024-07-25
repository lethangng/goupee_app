import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/question_model.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/tab_view_models/channel_tabs/thi_thu_view_model.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/exam/thi_thu_container.dart';
import '../../widgets/index_container.dart';
import '../../widgets/show_dialog_error.dart';

class ThiThuScreen extends StatelessWidget {
  ThiThuScreen({super.key});
  final ThiThuViewModel _thiThuViewModel = Get.put(ThiThuViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_thiThuViewModel.examHistoryAddRes.value.status == Status.error) {
        showDialogError(
            error: _thiThuViewModel.examHistoryAddRes.value.message!);
      }

      if (_thiThuViewModel.questionRes.value.status == Status.error) {
        showDialogError(error: _thiThuViewModel.questionRes.value.message!);
      }

      if (_thiThuViewModel.examHistoryAddRes.value.status == Status.completed ||
          _thiThuViewModel.examHistoryRes.value.status == Status.completed) {
        return screen();
      }

      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }

  Widget screen() {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        // centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Thời gian còn lại:',
          style: TextThemes.text14_500.copyWith(
            color: const Color(0xFFC1C1CD),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => handleBack(),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xFFFF6060)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/clock.svg'),
                const SizedBox(width: 4),
                RichText(
                  text: TextSpan(
                    text:
                        '${_thiThuViewModel.minutes.value.toString().length == 1 ? ("0${_thiThuViewModel.minutes.value}") : _thiThuViewModel.minutes.value}',
                    style: TextThemes.text18_400.copyWith(
                      color: const Color(0xFFFF6060),
                    ),
                    children: [
                      const TextSpan(text: ' : '),
                      TextSpan(
                          text:
                              '${_thiThuViewModel.seconds.value.toString().length == 1 ? ("0${_thiThuViewModel.seconds.value}") : _thiThuViewModel.seconds.value}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: () => handleSubmit(),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E47),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              elevation: 0,
            ),
            child: Text(
              'Nộp bài',
              style: TextThemes.text12_600,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFF353542),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => RichText(
                    text: TextSpan(
                      text: 'Câu: ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${_thiThuViewModel.isSelect.value + 1}',
                          style: const TextStyle(
                            color: Color(0xFFFF6E47),
                          ),
                          children: [
                            const TextSpan(text: '/'),
                            TextSpan(
                              text:
                                  '${_thiThuViewModel.listDataQuestion.length}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // RichText(
                    //   text: TextSpan(
                    //     text: '01',
                    //     style: TextThemes.text18_400.copyWith(
                    //       color: const Color(0xFFFF6E47),
                    //     ),
                    //     children: const [
                    //       TextSpan(text: ' : '),
                    //       TextSpan(text: '28'),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      // onTap: () => handleShow(),
                      onTap: () => _thiThuViewModel.handleWondering(),
                      child: Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _thiThuViewModel.getIsWondering()
                              ? const Color(0xFFFF6E47).withOpacity(0.5)
                              : const Color(0xFF747375),
                        ),
                        child: SvgPicture.asset('assets/icons/save-2.svg'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () => showTask(),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/task.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Color(0xFF353542),
          ),
          // const SizedBox(height: 24),
          Expanded(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                int index = _thiThuViewModel.isSelect.value;
                if (details.primaryVelocity! > 0) {
                  // User swiped Left
                  _thiThuViewModel.hanleOnSelect(index - 1);
                } else if (details.primaryVelocity! < 0) {
                  // User swiped Right
                  _thiThuViewModel.hanleOnSelect(index + 1);
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      ..._thiThuViewModel.listDataQuestion.mapIndexed(
                        (index, item) => Obx(
                          () => Visibility(
                            visible: index == _thiThuViewModel.isSelect.value,
                            child: ThiThuContainer(question: item),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: Get.width * 0.4,
          //   child: Column(
          //     children: [
          //       Image.asset('assets/icons/hand-left.png'),
          //       const SizedBox(height: 6),
          //       Text(
          //         'Vuốt sang trái để chuyển tiếp câu hỏi',
          //         textAlign: TextAlign.center,
          //         style: TextThemes.text14_500.copyWith(
          //           color: const Color(0xFFE0E0E6),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: Get.height * 0.1)
        ],
      ),
    );
  }

  void showTask() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.9,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24 * 2),
            Row(
              children: [
                const Text(
                  'Chỉ thị màu sắc:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const IndexContainer(
                  color: Color(0xFF83839C),
                  index: 0,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: 40,
                      left: -43,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDDD48),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Câu đã trả lời',
                              style: TextThemes.text16_400.copyWith(
                                color: const Color(0xFF28293D),
                              ),
                            ),
                          ),
                          SvgPicture.asset('assets/icons/tooltip-lam-de-1.svg'),
                        ],
                      ),
                    ),
                    const IndexContainer(
                      color: Color(0xFF007AFF),
                      index: 0,
                      size: 32,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const IndexContainer(
                      color: Color(0xFFFF6E47),
                      index: 0,
                      size: 32,
                    ),
                    Positioned(
                      bottom: -5,
                      left: 25,
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/tooltip-lam-de-2.svg'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDDD48),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Câu phân vân',
                              style: TextThemes.text16_400.copyWith(
                                color: const Color(0xFF28293D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: MasonryGridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: _thiThuViewModel.listDataQuestion.length,
                itemBuilder: (context, index) {
                  QuestionModel questionModel =
                      _thiThuViewModel.listDataQuestion[index];
                  return GestureDetector(
                    onTap: () {
                      _thiThuViewModel.hanleOnSelect(index);
                      Get.back();
                    },
                    child: IndexContainer(
                      color: handleColorQuestion(
                        isSelect: _thiThuViewModel.isSelect.value == index,
                        isWondering: questionModel.isWondering.value,
                        status: questionModel.status.value,
                      ),
                      index: index + 1,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF202025),
      isScrollControlled: true,
      // isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  Color handleColorQuestion({
    required AnswerStatus status,
    required bool isSelect,
    required bool isWondering,
  }) {
    if (status == AnswerStatus.isNull) {
      if (isSelect) {
        return const Color(0xFFFFFFFF);
      } else if (isWondering) {
        return const Color(0xFFFF6E47);
      } else {
        return const Color(0xFF83839C);
      }
    } else {
      return const Color(0xFF007AFF);
    }
  }

  void handleBack() {
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                      const SizedBox(height: 12),
                      const Text(
                        'Bạn chắc chắn muốn thoát chứ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Các câu bạn đã làm sẽ được lưu lại trong vòng 24 giờ. Nếu quá thời gian quy định, bạn sẽ phải làm lại từ đầu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Làm tiếp',
                              background: const Color(0xFF312E2E),
                              event: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Thoát',
                              event: () async {
                                await _thiThuViewModel.handleLoadEdit(0);
                                Get.offAllNamed(Routes.home);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleSubmit() {
    _thiThuViewModel.handlePreview();
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                      const SizedBox(height: 12),
                      const Text(
                        'Bạn chắc chắn muốn nộp bài chứ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bạn trả lời ${_thiThuViewModel.questionNotNull}/${_thiThuViewModel.listDataQuestion.length} câu. Bạn vẫn còn thời gian làm bài. Hãy kiểm tra lại bài thật kỹ nhé!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Làm tiếp',
                              background: const Color(0xFF312E2E),
                              event: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Nộp bài',
                              event: () {
                                // _thiThuViewModel.handlePreview();
                                Get.offAndToNamed(Routes.xacNhanNop);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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
