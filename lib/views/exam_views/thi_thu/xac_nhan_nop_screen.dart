import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';

// import '../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/channel_tabs/thi_thu_view_model.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/show_dialog_error.dart';

String getAnswerNumber(int index) {
  index = index + 64;
  if (index < 65) index = 65;
  if (index > 90) {
    int prefix = ((index - 65) / 26).floor();
    int suffix = index - 64 - prefix * 26;
    return getAnswerNumber(prefix) + getAnswerNumber(suffix);
  } else {
    return String.fromCharCode(index);
  }
}

class XacNhanNopScreen extends StatelessWidget {
  XacNhanNopScreen({super.key});
  final ThiThuViewModel _thiThuViewModel = Get.find<ThiThuViewModel>();

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    final height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(height: Get.height),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height + appBarHeight / 2),
                SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                const SizedBox(height: 12),
                const Text(
                  'Xác nhận nộp bài',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '''Bài làm của bạn sẽ được lưu lại và chấm điểm. 
Đối với các câu tự luận bạn sẽ xem đáp án sau khi nộp bài để tự so sánh .''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFE0E0E6),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFF4E4E61),
                ),
                const SizedBox(height: 12),
                Text(
                  'Check lại bài làm của bạn:',
                  style: TextThemes.text14_400.copyWith(
                    color: const Color(0xFFE0E0E6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: SizedBox(
                    height: Get.height *
                        (_thiThuViewModel.listPreview.length / 100),
                    child: MasonryGridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      crossAxisCount:
                          (_thiThuViewModel.listPreview.length / 4).ceil(),
                      crossAxisSpacing: 0,
                      mainAxisSpacing: Get.width * 0.14, // Fix cung
                      itemCount: _thiThuViewModel.listPreview.length,
                      itemBuilder: (context, index) {
                        return cauInfo(
                          title: index + 1,
                          value: _thiThuViewModel.listPreview[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  if (_thiThuViewModel.examHistoryEditRes.value.status ==
                      Status.error) {
                    showDialogError(
                      error: _thiThuViewModel.examHistoryEditRes.value.message!,
                    );
                  }

                  if (_thiThuViewModel.examHistoryEditRes.value.status ==
                      Status.loading) {
                    return const CircularProgressIndicator(
                      color: ColorApp.colorOrange,
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: ButtonPrimary(
                          title: 'Làm tiếp',
                          event: () => Get.back(),
                          background: const Color(0xFF312E2E),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonPrimary(
                          title: 'Xem kết quả',
                          event: () => _thiThuViewModel.handleLoadEdit(1),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cauInfo({
    required int title,
    String? value,
  }) {
    return SizedBox(
      width: title <= 90 ? 45 : 55,
      child: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: '$title',
          style: TextThemes.text18_400,
          children: [
            const TextSpan(text: '. '),
            TextSpan(
                text: value != null ? getAnswerNumber(int.parse(value)) : '--'),
          ],
        ),
      ),
    );
  }
}
