import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../models/home_models/package_model.dart';
import '../../../../../../services/response/api_status.dart';
import '../../../../../../utils/color_app.dart';
import '../../../../../../utils/text_themes.dart';
import '../../../../../../view_models/main_view_models/main_tabs/menu/info_views/g_point/nap_g_viewmodel.dart';
import '../../../../../widgets/show_dialog_error.dart';

class NapGScreen extends StatelessWidget {
  NapGScreen({super.key});
  final NapGViewmodel _napGViewmodel = Get.put(NapGViewmodel());

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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Chọn gói nạp',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (_napGViewmodel.packageRes.value.status == Status.error) {
                  showDialogError(
                      error: _napGViewmodel.packageRes.value.message!);
                }

                if (_napGViewmodel.packageRes.value.status ==
                    Status.completed) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _napGViewmodel.listData
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: containerNap(
                                isSelect: false,
                                package: item,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.colorOrange,
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text(
                'Chọn phương thức nạp',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              phuongThucContainer(
                icon: 'assets/icons/thanh-toan-1.png',
                title: 'Nạp tiền bằng tài khoản ngân hàng',
                event: () {},
              ),
              const SizedBox(height: 20),
              phuongThucContainer(
                icon: 'assets/icons/thanh-toan-2.png',
                title: 'Nạp tiền bằng ví điện tử Momo',
                event: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget phuongThucContainer({
    required String icon,
    required String title,
    void Function()? event,
  }) {
    return InkWell(
      onTap: event,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF27292D),
        ),
        child: Row(
          children: [
            Image.asset(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextThemes.text16_400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget containerNap({
    required bool isSelect,
    required PackageModel package,
  }) {
    return Expanded(
      child: Container(
        width: Get.width * 0.3,
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 160),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF27292D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: isSelect ? const Color(0xFFFF6E47) : const Color(0xFF27292D),
          ),
          boxShadow: const [
            // BoxShadow(
            //   color: const Color(0xFFFFFFFF).withOpacity(0.25),
            //   offset: const Offset(-18, -18),
            //   blurRadius: 36,
            // ),
            // BoxShadow(
            //   color: const Color(0xFF000000).withOpacity(0.02),
            //   offset: const Offset(1, 1),
            //   blurRadius: 2,
            // ),
            // BoxShadow(
            //   color: const Color(0xFFFFBD3D).withOpacity(0.47),
            //   offset: const Offset(18, 18),
            //   blurRadius: 36,
            // ),
          ],
        ),
        child: Column(
          children: [
            Text(
              package.title,
              style: TextThemes.text14_600,
            ),
            const SizedBox(height: 12),
            Text(
              package.price.toString(),
              style: TextThemes.text14_500.copyWith(
                color: const Color(0xFFFF6E47),
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: package.description.isNotEmpty,
              maintainSize: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    package.description,
                    style: TextThemes.text12_400.copyWith(
                      color: const Color(0xFFFF3434),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icons/coin-icon-2.png',
                  width: 24,
                ),
                const SizedBox(width: 5),
                Text(
                  '${package.g_point}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFDDD48),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
