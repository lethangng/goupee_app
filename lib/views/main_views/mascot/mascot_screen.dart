import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../utils/validate.dart';
import '../../../view_models/main_view_models/mascot/mascot_view_model.dart';
import '../../widgets/exam/exam3_container_item.dart';
import '../../widgets/loadmore.dart';
import '../../widgets/show_dialog_error.dart';

class MascotScreen extends StatelessWidget {
  MascotScreen({super.key});
  final MascotViewModel mascotViewModel = Get.put(MascotViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mascotViewModel.mascotRes.value.status == Status.error) {
        showDialogError(error: mascotViewModel.mascotRes.value.message!);
      }

      if (mascotViewModel.examRes.value.status == Status.error) {
        showDialogError(error: mascotViewModel.examRes.value.message!);
      }

      if (mascotViewModel.mascotRes.value.status == Status.completed &&
          mascotViewModel.examRes.value.status == Status.completed) {
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
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Linh vật AI',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
      ),
      body: Loadmore(
        refreshController: mascotViewModel.refreshController,
        onLoading: mascotViewModel.onLoadingExam,
        onRefresh: mascotViewModel.onRefresh,
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/icons/linh-vat-header.svg',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: Get.width * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...mascotViewModel.listData.map(
                            (item) => selectLinhVat(
                              id: item.id,
                              isSelect:
                                  item == mascotViewModel.mascotSelect.value,
                              linhVat: item.image,
                              event: () => mascotViewModel
                                  .handleChangeLinhVatSelect(item),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Owner: ${mascotViewModel.mascotSelect.value.user_fullname}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFE0E0E6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LV ${mascotViewModel.mascotSelect.value.current_level}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 200,
                          child: StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: mascotViewModel
                                .mascotSelect.value.current_percent,
                            size: 20,
                            padding: 0,
                            selectedColor: Colors.yellow,
                            unselectedColor:
                                const Color(0xFFFFA563).withOpacity(0.2),
                            roundedEdges: const Radius.circular(10),
                            selectedGradientColor: const LinearGradient(
                              colors: [
                                Color(0xFFFF8800),
                                Color(0xFFE63535),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${mascotViewModel.mascotSelect.value.current_percent} %',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.1),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/heart-icon-4.svg'),
                                const SizedBox(height: 4),
                                Text(
                                  '${mascotViewModel.mascotSelect.value.favourite_point}',
                                  style: TextThemes.text14_500,
                                ),
                                const SizedBox(height: 20),
                                Image.asset('assets/icons/coin-icon-2.png'),
                                const SizedBox(height: 4),
                                Text(
                                  '${mascotViewModel.mascotSelect.value.g_point}',
                                  style: TextThemes.text14_500,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(Validate.checkNullEmpty(
                                        mascotViewModel
                                            .mascotSelect.value.image)
                                    ? mascotViewModel.mascotSelect.value.image!
                                    : 'assets/icons/linh-vat-ai-main.png'),
                                const SizedBox(height: 32),
                                Text(
                                  'ID ${mascotViewModel.mascotSelect.value.id}',
                                  style: TextThemes.text16_500,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Kỹ năng',
                                  style: TextThemes.text14_500,
                                ),
                                const SizedBox(height: 12),
                                SvgPicture.asset('assets/images/chua-biet.svg'),
                                const SizedBox(height: 12),
                                SvgPicture.asset('assets/images/chua-biet.svg'),
                                const SizedBox(height: 12),
                                SvgPicture.asset('assets/images/chua-biet.svg'),
                              ],
                            )
                          ],
                        ),
                        // Positioned(
                        //   top: 70,
                        //   child: tooltip(),
                        // )
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: mascotViewModel.listExam.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    const Divider(
                      height: 1,
                      color: Color(0xFF353542),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Đề thi thuộc sở hữu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: mascotViewModel.listExam.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Exam3ContainerItem(
                            exam: mascotViewModel.listExam[index],
                          ),
                        );
                      },
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

  Widget tooltip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF312E2E),
          ),
          child: Row(
            children: [
              Text(
                '5,625 G',
                style: TextThemes.text16_500,
              ),
              const SizedBox(width: 12),
              Container(
                width: 1,
                height: 34,
                color: const Color(0xFF83839C),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '+56 G',
                        style: TextThemes.text16_500,
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/arrow-up.svg'),
                      Text(
                        '2%',
                        style: TextThemes.text16_500.copyWith(
                          color: const Color(0xFF2EE56B),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    '(Trong 24h)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC1C1CD),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 1,
                height: 34,
                color: const Color(0xFF83839C),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '+115 G',
                        style: TextThemes.text16_500,
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset('assets/icons/arrow-down-4.svg'),
                      Text(
                        '3%',
                        style: TextThemes.text16_500.copyWith(
                          color: const Color(0xFFFF3434),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    '(Trong 7 ngày)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC1C1CD),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 12),
            SvgPicture.asset('assets/icons/3.svg'),
          ],
        )
      ],
    );
  }

  void showDialog() {
    Get.dialog(
      barrierDismissible: true,
      Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: const BoxDecoration(
            color: Color(0xFF202025),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Image.asset('assets/images/container-thanh-tich.png'),
                Positioned.fill(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 68),
                      Image.asset('assets/images/lv 11.png'),
                      const SizedBox(height: 20),
                      const Text(
                        'Level Up',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Chúc mừng Goupee VCB đã tăng hạng thành công',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned.fill(
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 68),
                //     child: Align(
                //       alignment: Alignment.topCenter,
                //       child: Image.asset('assets/images/lv 11.png'),
                //     ),
                //   ),
                // ),
                // const Text(
                //   'Level Up',
                //   style: TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.w800,
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectLinhVat({
    required int id,
    required bool isSelect,
    Color background = const Color(0xFF211E1F),
    String? linhVat,
    required void Function() event,
    // bool isLast = false,
  }) {
    return GestureDetector(
      onTap: event,
      child: Padding(
        // padding: EdgeInsets.only(right: isLast ? 0 : 20),
        padding: const EdgeInsets.only(right: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                border: isSelect
                    ? Border.all(width: 2, color: const Color(0xFFFFC700))
                    : Border.all(width: 1.5, color: Colors.white),
                shape: BoxShape.circle,
                boxShadow: isSelect
                    ? [
                        BoxShadow(
                          blurRadius: 16,
                          offset: const Offset(0, 0),
                          color: const Color(0xFFFFC700).withOpacity(0.7),
                        ),
                      ]
                    : null,
              ),
              child: SvgPicture.asset(
                Validate.checkNullEmpty(linhVat)
                    ? linhVat!
                    : 'assets/icons/linh-vat-ai-1.svg',
                fit: BoxFit.cover,
                width: 44,
              ),
            ),
            Positioned(
              bottom: -13,
              left: 25,
              child: Visibility(
                visible: isSelect,
                child: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: SvgPicture.asset('assets/icons/arrow-down-3.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
