import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/color_app.dart';
import '../../../../../../utils/text_themes.dart';

class LichSuGSceen extends StatelessWidget {
  const LichSuGSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Lịch sử điểm G',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF353542),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF312E2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF4E4E61),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction time',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC1C1CD),
                        ),
                      ),
                      Text(
                        '02/08/2021 -> 21/08/2021',
                        style: TextThemes.text14_400,
                      )
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/arrow-down.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return historyContainer(
                    time: '2020-01-03 17:24:11',
                    price: '+20,000 đ',
                    coin: '20 G',
                    content:
                        '[VCB]RefMBVCB.31602833 2.CTSC098939012.CT tu 0611001892082 ...',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyContainer({
    required String time,
    required String price,
    required String coin,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF27292D),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Thời gian:',
                  style: TextThemes.text14_400.copyWith(
                    color: const Color(0xFFC1C1CD),
                  ),
                ),
                const Spacer(),
                Text(
                  time,
                  style: TextThemes.text14_400,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Số tiền:',
                  style: TextThemes.text14_400.copyWith(
                    color: const Color(0xFFC1C1CD),
                  ),
                ),
                const Spacer(),
                Text(
                  price,
                  style: TextThemes.text14_400.copyWith(
                    color: const Color(0xFF2EE56B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Số G:',
                  style: TextThemes.text14_400.copyWith(
                    color: const Color(0xFFC1C1CD),
                  ),
                ),
                const Spacer(),
                Text(
                  coin,
                  style: TextThemes.text14_400,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.3,
                  child: Text(
                    'Nội dung:',
                    style: TextThemes.text14_400.copyWith(
                      color: const Color(0xFFC1C1CD),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.end,
                    content,
                    style: TextThemes.text14_400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
