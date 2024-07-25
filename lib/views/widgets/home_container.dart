// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../view_models/main_view_models/main_tabs/home_tabs/home_tab_view_model.dart';
import '../../view_models/controllers/user_controller.dart';

class HomeContainer extends StatelessWidget {
  HomeContainer({
    super.key,
    required this.widget,
  });
  final HomeTabViewModel _homeTabViewModel = Get.find<HomeTabViewModel>();
  final UserController _userController = Get.find<UserController>();
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/images/logo.png',
        ),
        automaticallyImplyLeading: false, // Khong show leading
        actions: [
          Obx(() {
            if (_userController.userRes.value.data?.is_login != null) {
              return Container(
                height: size.width * 0.116,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: ColorApp.colorGrey6,
                  ),
                ),
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () => _homeTabViewModel.handleShowMenuBar(),
                  icon: SvgPicture.asset(
                    'assets/icons/menu-icon.svg',
                    width: size.width * 0.056,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return TextButton(
                onPressed: () => Get.toNamed(Routes.signup),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorApp.colorOrange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
          }),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     const Color(0xFFFF9055).withOpacity(0.15),
                //     const Color(0xFF000000).withOpacity(0),
                //     const Color(0xFF3371DB).withOpacity(0.15),
                //   ],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                ),
            child: Column(
              children: [
                SizedBox(
                  height: height + appBarHeight + 8,
                ),
                const Divider(
                  height: 1,
                  color: ColorApp.colorGrey7,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Container(
                  height: size.height * 0.06,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  decoration: BoxDecoration(
                    color: const Color(0xFF312E2E),
                    borderRadius: BorderRadius.circular(57),
                  ),
                  child: TextField(
                    cursorColor: ColorApp.colorGrey2,
                    style: const TextStyle(color: Colors.white),
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    readOnly: true,
                    onTap: () => Get.toNamed(Routes.searchView, arguments: {
                      'searchValue': null,
                    }),
                    decoration: InputDecoration(
                      isDense: true, // Cho chu can giua theo chieu doc
                      hintText: 'Tìm kiếm',
                      hintStyle: const TextStyle(
                        color: ColorApp.colorGrey2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Container(
                        width: 24,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/search-icon.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: widget,
                ),
              ],
            ),
          ),
          Obx(
            () => Positioned(
              top: appBarHeight + height + 10,
              right: 0,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: size.width * 0.65,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorApp.colorGrey8,
                      boxShadow: const [
                        // BoxShadow(
                        //   color: const Color(0xFF121212).withOpacity(0.15),
                        //   spreadRadius: 0,
                        //   blurRadius: 0,
                        //   offset: const Offset(0, 0),
                        // ),
                        // BoxShadow(
                        //   color: const Color(0xFF121212).withOpacity(0.15),
                        //   spreadRadius: 0,
                        //   blurRadius: 8,
                        //   offset: const Offset(0, 4),
                        // ),
                        // BoxShadow(
                        //   color: const Color(0xFF121212).withOpacity(0.13),
                        //   spreadRadius: 0,
                        //   blurRadius: 15,
                        //   offset: const Offset(0, 15),
                        // ),
                        // BoxShadow(
                        //   color: const Color(0xFF121212).withOpacity(0.08),
                        //   spreadRadius: 0,
                        //   blurRadius: 20,
                        //   offset: const Offset(0, 34),
                        // ),
                      ]),
                  height: _homeTabViewModel.showMenuBar.value ? null : 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rowMenuBarContainer(
                          title: 'Thông tin tài khoản',
                          icon: 'assets/icons/user-icon.svg',
                          event: () => Get.toNamed(Routes.info)),
                      rowMenuBarContainer(
                        title: 'Bảng xếp hạng',
                        icon: 'assets/icons/ranking-icon.svg',
                        event: () => Get.toNamed(Routes.bxh),
                        isLast: true,
                      ),
                      // rowMenuBarContainer(
                      //   title: 'Nhiệm vụ',
                      //   icon: 'assets/icons/nhiem-vu.svg',
                      //   event: () {},
                      // ),
                      // rowMenuBarContainer(
                      //   title: 'Thành tích',
                      //   icon: 'assets/icons/thanh-tich.svg',
                      //   event: () {},
                      // ),
                      // rowMenuBarContainer(
                      //   title: 'Hỏi đáp',
                      //   icon: 'assets/icons/messages-icon.svg',
                      //   event: () {},
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowMenuBarContainer({
    required String title,
    required String icon,
    required void Function() event,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: () {
        _homeTabViewModel.handleShowMenuBar();
        event();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
