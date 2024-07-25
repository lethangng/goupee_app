// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../app/routes.dart';
import '../../models/Exam/exam_history.dart';

enum HistoryItemType {
  slacking,
  history,
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.type,
    required this.examHistory,
    required this.event,
  });
  final HistoryItemType type;
  final ExamHistory examHistory;
  final void Function() event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: type == HistoryItemType.slacking ? () => handleShow() : event,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF312E2E),
          borderRadius: BorderRadius.circular(12),
          border: const Border(
            left: BorderSide(
              color: Color(0xFFFF6E47),
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.6),
              child: Text(
                examHistory.exam_title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  examHistory.submit_time,
                  style: const TextStyle(
                    color: Color(0xFFC1C1CD),
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                type == HistoryItemType.slacking ? content1() : content2(),
                const SizedBox(width: 16),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget content2() {
    return RichText(
      text: TextSpan(
        text: 'Điểm: ',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFFC1C1CD),
        ),
        children: [
          TextSpan(
            text: examHistory.total_true.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF2EE56B),
            ),
            children: [
              TextSpan(
                text: '/',
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: examHistory.total_question.toString())
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget content1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${examHistory.start_from + 1}/${examHistory.total_question}',
          style: const TextStyle(
            color: Color(0xFFC1C1CD),
            fontSize: 13,
          ),
        ),
        LinearPercentIndicator(
          width: 100,
          lineHeight: 4,
          backgroundColor: Colors.white,
          progressColor: const Color(0xFF05A660),
          percent: examHistory.start_from / examHistory.total_question,
          barRadius: const Radius.circular(100),
          animation: true,
          animationDuration: 1000,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void handleShow() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                      Text(
                        'Bạn đang làm đến câu ${examHistory.start_from}, Bạn có muốn làm tiếp không?',
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
                            child: button(
                              title: 'Làm lại từ đầu',
                              backgroundColor: const Color(0xFF312E2E),
                              event: () => Get.offNamed(
                                Routes.thiThu,
                                arguments: {
                                  'examHistoryId': examHistory.id,
                                  'examId': examHistory.exam_id,
                                  'totalQuestion': examHistory.total_question,
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: button(
                              title: 'Làm tiếp',
                              backgroundColor: const Color(0xFFFF6E47),
                              event: () => Get.offNamed(
                                Routes.thiThu,
                                arguments: {
                                  'examHistoryId': examHistory.id,
                                  'examId': examHistory.exam_id,
                                  'examHistory': examHistory,
                                  'totalQuestion': examHistory.total_question,
                                  'start_from': examHistory.start_from,
                                },
                              ),
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
      barrierDismissible: false,
    );
  }

  Widget button({
    required String title,
    required Color backgroundColor,
    void Function()? event,
  }) {
    return FilledButton(
      onPressed: event,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
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
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
