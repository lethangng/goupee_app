import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../../../utils/color_app.dart';
import '../../../../../../utils/text_themes.dart';

TextStyle textHeader = const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

class GioiThieuScreen extends StatelessWidget {
  const GioiThieuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Giới thiệu bạn bè',
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
        child: Column(
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF353542),
            ),
            Image.asset('assets/images/gioi-thieu-header.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giới thiệu bạn bạn ngay',
                    style: textHeader,
                  ),
                  Row(
                    children: [
                      Text(
                        'Nhận ${5} ',
                        style: textHeader,
                      ),
                      Image.asset('assets/icons/coin-icon-2.png'),
                      Text(
                        ' liền tay',
                        style: textHeader,
                      ),
                    ],
                  ),
                  const SizedBox(height: 21),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1013),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFA0D2FF),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dùng link và mã giới thiệu dưới đây để gửi cho bạn bè của bạn!',
                          style: TextThemes.text14_600,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  rowGioiThieu(
                                    title: 'Link giới thiệu',
                                    value: 'https://referral.goupeeapp...',
                                  ),
                                  const SizedBox(height: 12),
                                  rowGioiThieu(
                                    title: 'Mã giới thiệu',
                                    value: '0868413002',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/qr.svg',
                                  width: 80,
                                  height: 80,
                                ),
                                const Text(
                                  'Scan QR code',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () => onShowCopy(),
                          style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFFF6E47)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/share-3.svg'),
                              const SizedBox(width: 8),
                              Text(
                                'Giới thiệu bạn bè',
                                style: TextThemes.text16_600,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hướng dẫn tham gia',
                    style: TextThemes.text16_600,
                  ),
                  timeLine(
                    index: 1,
                    isFirst: true,
                    value: 'Chia sẻ link giới thiệu tới bạn bè',
                  ),
                  timeLine(
                    index: 2,
                    value: 'Bạn bè của bạn tải App Goupee và đăng ký tài khoản',
                  ),
                  timeLine(
                    isLast: true,
                    value:
                        'Ở bước đăng ký, nhập mã giới thiệu và bạn sẽ được nhận ngay 5G',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onShowCopy() {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Container(
          width: Get.width * 0.8,
          decoration: const BoxDecoration(
            color: Color(0xFF202025),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Giới thiệu bạn bè',
                        style: TextThemes.text16_600,
                      ),
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
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    'assets/icons/qr.svg',
                    width: Get.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  rowInfoCopy(
                    title: 'Link giới thiệu',
                    value: 'https://referral.goupe...',
                  ),
                  const SizedBox(height: 16),
                  rowInfoCopy(
                    title: 'Mã giới thiệu',
                    value: '123546',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: button4(
                          title: 'Tải xuống',
                          icon: 'assets/icons/download-2.svg',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 18,
                        color: const Color(0xFF83839C),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: button4(
                            title: 'Chia sẻ',
                            icon: 'assets/icons/share-2.svg',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowInfoCopy({
    required String title,
    required String value,
    void Function()? event,
  }) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFF353535),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextThemes.text14_400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 14),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: value));
                    // Get.snackbar(
                    //   '',
                    //   'Sao chép thành công',
                    //   // snackPosition: SnackPosition.BOTTOM,
                    // );
                  },
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: SvgPicture.asset('assets/icons/copy-2.svg'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget button4({
    required String title,
    required String icon,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF6E47),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeLine({
    int? index,
    bool isFirst = false,
    bool isLast = false,
    required String value,
  }) {
    return TimelineTile(
      isLast: isLast,
      isFirst: isFirst,
      afterLineStyle: const LineStyle(
        thickness: 1,
        color: Colors.white,
      ),
      beforeLineStyle: const LineStyle(
        thickness: 1,
        color: Colors.white,
      ),
      indicatorStyle: IndicatorStyle(
        width: 36,
        height: 36,
        indicator: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFE5E5),
          ),
          child: isLast
              ? Image.asset(
                  'assets/icons/coin-icon-2.png',
                  width: 26,
                )
              : Text(
                  '$index',
                  style: TextThemes.text16_600.copyWith(
                    color: const Color(0xFFEF4E28),
                  ),
                ),
        ),
      ),
      endChild: Padding(
        padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF0F1013),
          ),
          child: Text(
            value,
            style: TextThemes.text14_400,
          ),
        ),
      ),
    );
  }

  Widget rowGioiThieu({
    required String title,
    required String value,
    void Function()? event,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF312E2E),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextThemes.text14_400,
                ),
              ),
              InkWell(
                onTap: () => Clipboard.setData(ClipboardData(text: value)),
                child: SvgPicture.asset('assets/icons/copy-2.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
