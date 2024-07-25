import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../models/home_models/top_exam_model.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/text_themes.dart';
import '../../../../../view_models/tab_view_models/channel_tabs/top_exam_controller.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class TopExamTab extends StatelessWidget {
  TopExamTab({super.key});
  final TopExamController _topExamController = Get.put(TopExamController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_topExamController.topExamRes.value.status == Status.error) {
        showDialogError(error: _topExamController.topExamRes.value.message!);
      }

      if (_topExamController.topExamRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _topExamController.refreshController,
          onLoading: _topExamController.onLoading,
          onRefresh: _topExamController.onRefresh,
          widget: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _topExamController.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return rowDeThi(
                index: index + 1,
                topExam: _topExamController.listData[index],
                isFirst: index == 0,
              );
            },
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }

  Widget rowDeThi({
    required int index,
    required TopExamModel topExam,
    required bool isFirst,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isFirst ? const Color(0xFFFFB380) : const Color(0xFF312E2E),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$index',
                  textAlign: TextAlign.end,
                  style: TextThemes.text14_600.copyWith(
                    color: isFirst ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                SizedBox(
                  width: Get.width * 0.6,
                  child: Text(
                    topExam.title,
                    style: TextThemes.text14_500.copyWith(
                      color: isFirst ? Colors.black : const Color(0xFFFF6E47),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${topExam.total_favourites}',
                  style: TextThemes.text14_600.copyWith(
                    color: isFirst ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset('assets/icons/heart-icon.svg'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
