import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/color_app.dart';
import '../../../../../../utils/text_themes.dart';

class NapG2Screen extends StatelessWidget {
  const NapG2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Nạp G',
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/time-history.svg'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF353542),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 16,
                  //     horizontal: 12,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(24),
                  //     color: Colors.white.withOpacity(0.44),
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           vertical: 12,
                  //           horizontal: 16,
                  //         ),
                  //         child: Image.asset(
                  //           'assets/images/nap-g-header.png',
                  //           width: Get.width,
                  //           fit: BoxFit.fill,
                  //         ),
                  //       ),
                  //       Positioned.fill(
                  //         child: Align(
                  //           alignment: Alignment.center,
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   Image.asset(
                  //                     'assets/icons/coin-icon-2.png',
                  //                     width: 36,
                  //                   ),
                  //                   const SizedBox(width: 8),
                  //                   const Text(
                  //                     '862',
                  //                     style: TextStyle(
                  //                       fontSize: 40,
                  //                       fontWeight: FontWeight.w700,
                  //                       color: Color(0xFFFDDD48),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   Text(
                  //                     'Tổng nạp: ',
                  //                     style: TextStyle(
                  //                       fontSize: 12,
                  //                       fontWeight: FontWeight.w500,
                  //                       color: Color(0xFFCCDDFF),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     '9000 G',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w700,
                  //                       color: Colors.white,
                  //                     ),
                  //                   )
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/images/nap-g-header.svg',
                        width: Get.width,
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Image.asset(
                              'assets/images/nap-g-header.png',
                              width: Get.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icons/coin-icon-2.png',
                                    width: 36,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '862',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFDDD48),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Tổng nạp: ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFCCDDFF),
                                    ),
                                  ),
                                  Text(
                                    '9000 G',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF27292D),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/icons/thanh-toan-1.png'),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Nạp tiền bằng tài khoản ngân hàng',
                                  style: TextThemes.text16_400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              text: 'Bước 1:',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Quét mã/ Chuyển tiền:',
                                  style: TextThemes.text14_500,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset(
                            'assets/images/bank.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFF353542),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Bạn đang nạp gói G1',
                            style: TextThemes.text14_500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFFFF6E47),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Gói G1:',
                                  style: TextThemes.text14_600,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '50.000đ',
                                  style: TextThemes.text14_500.copyWith(
                                    color: const Color(0xFFFF6E47),
                                  ),
                                ),
                                const Spacer(),
                                Image.asset(
                                  'assets/icons/coin-icon-2.png',
                                  width: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '50',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFDDD48),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFF353542),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              text: 'Bước 2 (quan trọng):',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Nhập nội dung chuyển tiền:',
                                  style: TextThemes.text14_500,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: Get.width * 0.7,
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: const Border.symmetric(
                                horizontal:
                                    BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: const Text(
                              'Goupee [số điện thoại]',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Các giao dịch không nhập nội dung chuyển tiền, hoặc nhập không đúng nội dung theo yêu cầu sẽ không được cộng xu tự động.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFC1C1CD),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              //
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/icons/nap-g.svg'),
                                const SizedBox(width: 8),
                                Text(
                                  'Xem hướng dẫn',
                                  style: TextThemes.text14_600.copyWith(
                                    color: const Color(0xFFFF6E47),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFF353542),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Bước 3:',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Check trạng thái chuyển tiền:',
                                      style: TextThemes.text14_500,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                    'assets/images/nap-g-linh-vat.png'),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Nạp G thành công',
                                  style: TextThemes.text14_600.copyWith(
                                    color: const Color(0xFF2EE56B),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: Get.width * 0.6,
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    'Bạn vừa nạp thành công 30.000 vnđ tương ứng với 30G',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFC1C1CD),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Khu vực tải ảnh',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFC1C1CD),
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: double.infinity,
                                child: DottedBorder(
                                  color: Colors.white,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(8),
                                  strokeWidth: 1,
                                  dashPattern: const [8, 4],
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/upload-image.svg'),
                                        const Text(
                                          'Tải lên ảnh chụp chuyển khoản để đợi duyệt',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFC1C1CD),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
