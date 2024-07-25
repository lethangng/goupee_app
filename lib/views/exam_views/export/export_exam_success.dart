import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/exam_view_models/export_exam_susscess_view_model.dart';
import '../../widgets/button_primary.dart';

class ExportExamSusscess extends StatelessWidget {
  ExportExamSusscess({super.key});
  final ExportExamSusscessViewModel _exportExamSusscessViewModel =
      Get.put(ExportExamSusscessViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height + 44),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/exam.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/exam-2.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Positioned(
                bottom: -10,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: -5,
                      child: SvgPicture.asset('assets/icons/shadow.svg'),
                    ),
                    Image.asset(
                      'assets/images/success-linhvat.png',
                      // width: double.infinity,
                      // fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Đề được xuất thành công',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.8,
            child: const Text(
              'Đề thi vừa xuất được lưu vào mục đề thi của bạn',
              style: TextStyle(
                color: Color(0xFFbebeca),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ButtonPrimary(
            title: 'Tạo đề khác',
            size: size.width * 0.8,
            background: const Color(0xFFFF6E47),
            event: () => Get.offAllNamed(Routes.create),
          ),
          Visibility(
            visible: _exportExamSusscessViewModel.type != 'delete',
            child: Column(
              children: [
                const SizedBox(height: 10),
                ButtonPrimary(
                  title: 'Đến đề thi',
                  size: size.width * 0.8,
                  background: const Color(0xFFFF6E47),
                  event: () => Get.toNamed(Routes.examDetail, arguments: {
                    'examId': _exportExamSusscessViewModel.examId
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ButtonPrimary(
            title: 'Về trang chủ',
            size: size.width * 0.8,
            background: const Color(0xFF312E2E),
            event: () => Get.offAllNamed(Routes.home),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
