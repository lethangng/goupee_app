import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../app/routes.dart';
import '../../models/Exam/exam_detail_response.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../view_models/exam_view_models/edit_exam_viewmodel.dart';
import '../../view_models/exam_view_models/view_exam_view_model.dart';
import '../../view_models/tab_view_models/channel_tabs/exam_detail_view_model.dart';
import '../widgets/exam/content_exam.dart';

class EditExamScreen extends StatelessWidget {
  EditExamScreen({super.key});
  final EditExamViewmodel _editExamViewmodel = Get.put(EditExamViewmodel());
  final ViewExamViewModel _viewExamViewModel = Get.put(ViewExamViewModel());
  final ExamDetailViewModel _examDetailViewModel =
      Get.find<ExamDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    double sizeWidth = Get.width;
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        // toolbarHeight: 100,
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        title: Text(
          'Xem trước đề thi',
          style: TextThemes.text18_500,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              List<int> listQuestionId = _editExamViewmodel.listQuestionVal
                  .map((item) => item.id)
                  .toList();

              ExamDetail examDetail =
                  _examDetailViewModel.examDetailRes.value.data!.exam_detail;
              int examType = examDetail.type;

              String? imageValue = examDetail.image;

              String sampleExamTitle = examDetail.title;

              Get.toNamed(Routes.inputInfoExam, arguments: {
                'listQuestionId': listQuestionId,
                'examType': examType,
                'sampleExamTitle': sampleExamTitle,
                'imageVal': imageValue,
                // 'addExam': false,
                'examId': examDetail.id,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E47),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
            ),
            child: Text(
              'Xuất đề',
              style: TextThemes.text12_600,
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: _editExamViewmodel.listQuestionVal
                        .mapIndexed(
                          (index, item) => GestureDetector(
                            onTap: () =>
                                _viewExamViewModel.hanleOnSelect(index + 1),
                            child: Container(
                              width: 40,
                              margin: const EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: (_viewExamViewModel.isSelect.value ==
                                          index + 1)
                                      ? Colors.white
                                      : const Color(0xFF83839C),
                                ),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: (_viewExamViewModel.isSelect.value ==
                                          index + 1)
                                      ? Colors.white
                                      : const Color(0xFF83839C),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    int index = _viewExamViewModel.isSelect.value;
                    if (details.primaryVelocity! > sizeWidth * 0.2) {
                      // User swiped Left
                      _viewExamViewModel.hanleOnSelect(index - 1);
                    } else if (details.primaryVelocity! < sizeWidth * 0.2) {
                      // User swiped Right
                      _viewExamViewModel.hanleOnSelect(index + 1);
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: _editExamViewmodel.listQuestionVal
                          .mapIndexed((index, item) => Visibility(
                                visible: index + 1 ==
                                    _viewExamViewModel.isSelect.value,
                                child: ContentExam(
                                  question: item,
                                  isEdit: true,
                                  eventDelete: () {
                                    _editExamViewmodel
                                        .handleDeleteQuestionId(item.id);
                                    Get.back();
                                  },
                                  isListEmpty: _editExamViewmodel
                                          .listQuestionVal.length ==
                                      1,
                                  eventDeleteEmpty: () =>
                                      _editExamViewmodel.handleLoadDelete(),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
