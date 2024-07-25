import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/main_view_models/main_wrapper/main_tab_view_model.dart';
import '../../../view_models/controllers/user_controller.dart';
import '../../widgets/login_empty.dart';
import '../main_tabs/my_channel_tabs/my_channel_tab.dart';
import '../main_tabs/home_tabs/home_tab_view.dart';
import '../main_tabs/notification_tabs/notificaion_tab.dart';
import '../main_tabs/slacking_tabs/slacking_tab.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final MainTabViewModel _tabViewModel = Get.put(MainTabViewModel());
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    int? isLogin = _userController.userRes.value.data?.is_login;
    return Scaffold(
      extendBody: true, // cho mau cua bottomNavigationBar thanh trong suot
      backgroundColor: ColorApp.colorBlack4,
      body: PageView(
        onPageChanged: _tabViewModel.animateToTab,
        controller: _tabViewModel.pageController,
        children: [
          HomeTabView(),
          isLogin != null ? MyChannelTab() : const LoginEmpty(),
          isLogin != null ? SlackingTab() : const LoginEmpty(),
          isLogin != null ? const NotificationTab() : const LoginEmpty(),
          // const SlackingTab(),
          // const NotificationTab(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        notchMargin: 10,
        elevation: 0.0,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset(
                'assets/images/bottom-nav.svg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ZoomTapAnimation(
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(top: 7),
                  child: GestureDetector(
                    onTap: () {
                      if (_userController.userRes.value.data != null) {
                        Get.toNamed(Routes.create);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorApp.colorOrange3,
                          ),
                          height: 44,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/icons/logo-bottom-icon.svg',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: _userController.userRes.value.data != null
                                ? ColorApp.colorOrange3
                                : ColorApp.colorGrey3,
                          ),
                          child: const Text(
                            'Tạo mới',
                            style: TextStyle(
                              color: ColorApp.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(
                () => Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomAppBarItem(
                      context,
                      icon: 'home-icon',
                      page: 0,
                      lable: 'Trang chủ',
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: 'crown-icon',
                      page: 1,
                      lable: 'Kênh của tôi',
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: 'book-icon',
                      page: 2,
                      lable: 'Chưa xong',
                    ),
                    _bottomAppBarItem(
                      context,
                      icon: 'notificaion-icon',
                      page: 3,
                      lable: 'Thông báo',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required icon,
    required page,
    required lable,
  }) {
    return Expanded(
      child: ZoomTapAnimation(
        onTap: () => _tabViewModel.goToTab(page),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/icons/${_tabViewModel.currentPage.value == page ? icon + '-light' : icon}.svg',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                lable,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _tabViewModel.currentPage.value == page
                      ? ColorApp.white
                      : ColorApp.colorGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
