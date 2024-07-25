import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../view_models/tab_view_models/channel_tabs/success_exam_view_model.dart';
import '../../widgets/button_primary.dart';

class SuccessExamScreen extends StatelessWidget {
  SuccessExamScreen({super.key});

  final SuccessExamViewModel _successExamViewModel =
      Get.put(SuccessExamViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff201E1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/exam.png',
            width: size.width,
          ),
          Stack(
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
          const SizedBox(height: 38),
          const Text(
            'Bạn vừa hoàn thành ôn tập',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2EE56B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Đề thi tín dụng Vietcombank',
            style: TextStyle(
              color: Color(0xFFE0E0E6),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: '${_successExamViewModel.countTrue}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2EE56B),
              ),
              children: [
                const TextSpan(
                    text: '/', style: TextStyle(color: Colors.white)),
                TextSpan(
                  text: '${_successExamViewModel.length}',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          const Spacer(),
          ButtonPrimary(
            title: 'Về trang chủ',
            size: size.width * 0.78,
            event: () => Get.offAndToNamed(Routes.home),
            // event: () => _successExamViewModel.initDialog(),
          ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }

  Widget button({
    required String title,
    required bool isResult,
    required event,
    required double size,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      child: Container(
          width: size,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isResult ? const Color(0xFFFF6E47) : const Color(0xFF312E2E),
          ),
          alignment: Alignment.center,
          child: Text(title)),
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
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            value,
            style: TextStyle(
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
