import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../utils/color_app.dart';

enum StatusTimeLine {
  complete,
  unfinished,
  isNull,
}

class NhiemVuScreen extends StatelessWidget {
  const NhiemVuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Nhiệm vụ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFF353542),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/background-nhiem-vu.svg',
                      width: Get.width,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Điểm của bạn',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Image.asset('assets/icons/coin-icon.png')
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    '862',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFDDD48),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: RichText(
                                      text: const TextSpan(
                                        text: ' = ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFC1C1CD),
                                        ),
                                        children: [
                                          TextSpan(text: '862K'),
                                          TextSpan(text: ' vnđ'),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFFF6E47),
                              minimumSize: Size.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Nạp tiền',
                              style: TextThemes.text14_600,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9A35), Color(0xFFFF6033)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Hoàn thành nhiệm vụ hàng ngày để nhận điểm từ Goupee nhé!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(
                    //   height: 100,
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: ListView.builder(
                    //       itemCount: 1,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return timeLine(index: index, isFirst: index == 0, );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 100,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            timeLine(index: 0, isFirst: true),
                            timeLine(
                                index: 1, status: StatusTimeLine.unfinished),
                            timeLine(index: 2, isNext: true),
                            timeLine(index: 3),
                            timeLine(index: 4),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    nhiemVuContainer(),
                    const SizedBox(height: 16),
                    nhiemVuContainer(),
                    const SizedBox(height: 16),
                    nhiemVuContainer(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF35B6FF), Color(0xFF3354FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    nhiemVuContainer(),
                    const SizedBox(height: 16),
                    nhiemVuContainer(),
                    const SizedBox(height: 16),
                    nhiemVuContainer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nhiemVuContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFDDC7),
              ),
              child: Image.asset('assets/images/nhiem-vu-1.png'),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thành viên mới',
                style: TextThemes.text16_500.copyWith(
                  color: const Color(0xFF201E1F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '5G',
                style: TextThemes.text14_500.copyWith(
                  color: const Color(0xFF979797),
                ),
              ),
              const SizedBox(height: 4),
              Stack(
                children: [
                  const SizedBox(
                    width: 120,
                    child: StepProgressIndicator(
                      totalSteps: 1,
                      currentStep: 1,
                      size: 16,
                      padding: 0,
                      selectedColor: Colors.yellow,
                      unselectedColor: Color(0xFFE0E0E6),
                      roundedEdges: Radius.circular(8),
                      selectedGradientColor: LinearGradient(
                        colors: [
                          Color(0xFFFF8800),
                          Color(0xFFE63535),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: '1',
                          style: TextThemes.text14_500.copyWith(
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(text: '/'),
                            TextSpan(text: '1'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E47),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 6.5,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Xem',
              style: TextThemes.text16_500.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  IndicatorStyle hanleIndicatorStyle({
    required bool isFirst,
    required bool isComplete,
  }) {
    if (isFirst) {
      return IndicatorStyle(
        width: 36,
        height: 36,
        indicator: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF56ad70),
            border: Border.all(
              width: 1,
              color: const Color(0xFF60CC65),
            ),
          ),
          child: SvgPicture.asset('assets/icons/star-2.svg'),
        ),
      );
    } else {
      if (isComplete) {
        return IndicatorStyle(
          width: 17,
          height: 17,
          indicator: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF56ad70),
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
            child: SvgPicture.asset('assets/icons/tick-success.svg'),
          ),
        );
      }
      return const IndicatorStyle(
        width: 17,
        height: 17,
        color: Color(0xFFCC5F2A),
      );
    }
  }

  Widget handleStartChild({
    required bool isFirst,
    required StatusTimeLine status,
  }) {
    if (isFirst) {
      return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircularPercentIndicator(
          radius: 20,
          lineWidth: 2.4,
          percent: 1,
          backgroundColor: const Color(0xFFfcae70),
          progressColor: const Color(0xFFFF3434),
          center: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '5',
                style: TextThemes.text14_500.copyWith(
                  color: const Color(0xFF201E1F),
                ),
              ),
              const SizedBox(width: 2),
              Image.asset(
                'assets/icons/coin-icon.png',
                width: 10,
                height: 10,
              ),
            ],
          ),
        ),
      );
    } else {
      if (status == StatusTimeLine.unfinished) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircularPercentIndicator(
              radius: 25,
              lineWidth: 3,
              percent: 0.25,
              backgroundColor: const Color(0xFFfcae70),
              progressColor: const Color(0xFFFF3434),
              center: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '1',
                    style: TextThemes.text14_500.copyWith(
                      color: const Color(0xFF201E1F),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: '5',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF201E1F),
                          ),
                          children: [
                            TextSpan(
                              text: '/',
                              style: TextStyle(
                                color: Color(0xFFC1C1CD),
                              ),
                            ),
                            TextSpan(
                              text: '12',
                              style: TextStyle(
                                color: Color(0xFFC1C1CD),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/icons/coin-icon.png',
                        width: 10,
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC84200),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '2',
                  style: TextThemes.text14_500,
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: '10',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      'assets/icons/coin-icon.png',
                      width: 10,
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  LineStyle handleLineStyle({
    required bool isFirst,
    required StatusTimeLine status,
  }) {
    if (isFirst) {
      return const LineStyle(
        thickness: 4,
        color: Color(0xFF7AE46A),
      );
    } else {
      if (status == StatusTimeLine.isNull) {
        return const LineStyle(
          thickness: 4,
          color: Color(0xFFCC5F2A),
        );
      } else {
        return const LineStyle(
          thickness: 4,
          color: Color(0xFF7AE46A),
        );
      }
    }
  }

  Widget timeLine({
    bool isFirst = false,
    bool isNext = false,
    StatusTimeLine status = StatusTimeLine.isNull,
    required int index,
  }) {
    return TimelineTile(
      lineXY: 0.7,
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.manual,
      isFirst: isFirst,
      afterLineStyle: isNext
          ? const LineStyle(
              thickness: 4,
              color: Color(0xFFCC5F2A),
            )
          : handleLineStyle(isFirst: isFirst, status: status),
      beforeLineStyle: isNext
          ? const LineStyle(
              thickness: 4,
              color: Color(0xFF7AE46A),
            )
          : handleLineStyle(isFirst: isFirst, status: status),
      indicatorStyle: hanleIndicatorStyle(
        isFirst: isFirst,
        isComplete: status == StatusTimeLine.complete ||
            status == StatusTimeLine.unfinished ||
            isNext,
      ),
      startChild: handleStartChild(
        isFirst: isFirst,
        status: status,
      ),
    );
  }
}
