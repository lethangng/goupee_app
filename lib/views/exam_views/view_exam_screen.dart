import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../view_models/exam_view_models/create_exam_2_view_model.dart';
import '../../view_models/exam_view_models/view_exam_view_model.dart';
import '../widgets/exam/content_exam.dart';

class ViewExamScreen extends StatelessWidget {
  ViewExamScreen({super.key});

  final ViewExamViewModel _viewExamViewModel = Get.put(ViewExamViewModel());
  final CreateExam2ViewModel _createExam2ViewModel =
      Get.find<CreateExam2ViewModel>();

  @override
  Widget build(BuildContext context) {
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
              List<int> listQuestionId = _createExam2ViewModel.listQuestionVal
                  .map((item) => item.id)
                  .toList();
              int examType = _createExam2ViewModel.examType;

              final List<String> images =
                  _createExam2ViewModel.sentenceSearch.images;

              String? imageValue = images.isNotEmpty
                  ? images[Random().nextInt(images.length)]
                  : null;

              String sampleExamTitle =
                  _createExam2ViewModel.sentenceSearch.sample_exam_title;

              Get.toNamed(Routes.inputInfoExam, arguments: {
                'listQuestionId': listQuestionId,
                'examType': examType,
                'sampleExamTitle': sampleExamTitle,
                'imageVal': imageValue,
                'addExam': true,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     const Color(0xFFFF9055).withOpacity(0.15),
              //     const Color(0xFF000000).withOpacity(0),
              //     const Color(0xFF3371DB).withOpacity(0.15),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: _createExam2ViewModel.listQuestionVal
                              .mapIndexed(
                                (index, item) => Obx(
                                  () {
                                    return GestureDetector(
                                      onTap: () => _viewExamViewModel
                                          .hanleOnSelect(index + 1),
                                      child: Container(
                                        width: 40,
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: (_viewExamViewModel
                                                        .isSelect.value ==
                                                    index + 1)
                                                ? Colors.white
                                                : const Color(0xFF83839C),
                                          ),
                                        ),
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: (_viewExamViewModel
                                                        .isSelect.value ==
                                                    index + 1)
                                                ? Colors.white
                                                : const Color(0xFF83839C),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList()),
                    ),
                    Column(
                      children: _createExam2ViewModel.listQuestionVal
                          .mapIndexed(
                            (index, item) => Obx(
                              () {
                                return Visibility(
                                  visible: index + 1 ==
                                      _viewExamViewModel.isSelect.value,
                                  child: ContentExam(
                                    question: item,
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
