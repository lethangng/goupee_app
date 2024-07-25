import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';

import '../../../../../../app/routes.dart';
// import '../../../../../../models/table/user.dart';
import '../../../../../../view_models/main_view_models/main_wrapper/main_tab_view_model.dart';
import '../../../../../../view_models/tab_view_models/info_view_model.dart';
import '../../../../../../view_models/controllers/user_controller.dart';
import '../../../../../widgets/avatar_container.dart';

class InfoScreen extends StatelessWidget {
  InfoScreen({super.key});

  final InfoViewModel _infoViewModel = Get.put(InfoViewModel());
  final UserController _userController = Get.find<UserController>();
  final MainTabViewModel _tabViewModel = Get.find<MainTabViewModel>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: const Color(0xFF18191A),
      // extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/images/info-header.svg',
                  width: Get.width,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: height + appBarHeight),
                      Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/info-header-container.svg',
                            width: Get.width,
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: Get.width * 0.8,
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        AvatarContainer(
                                          radius: 80,
                                          image: _userController
                                              .userRes.value.data!.image,
                                          replaceImage:
                                              'assets/images/avatar-1.png',
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${_userController.userRes.value.data!.channel_title}',
                                                  style: TextThemes.text14_500,
                                                ),
                                                const SizedBox(width: 4),
                                                SvgPicture.asset(
                                                    'assets/icons/tick-circle-icon.svg'),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icons/group.svg'),
                                                const SizedBox(width: 4),
                                                RichText(
                                                  text: TextSpan(
                                                    text: _userController
                                                        .userRes
                                                        .value
                                                        .data!
                                                        .total_favourites
                                                        .toString(),
                                                    style: TextThemes.text14_400
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFFC1C1CD),
                                                    ),
                                                    children: const [
                                                      TextSpan(text: ' '),
                                                      TextSpan(
                                                          text: 'followers')
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Image.asset(
                                                'assets/icons/coin-icon-2.png',
                                                width: 28.5,
                                              ),
                                            ),
                                            Positioned(
                                              left: 20,
                                              bottom: 15,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 2,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFF3B3B),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(2),
                                                  ),
                                                ),
                                                child: Text(
                                                  _userController.userRes.value
                                                      .data!.g_points
                                                      .toString(),
                                                  style: TextThemes.text14_500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  rowInfo(
                    icon: 'assets/icons/info-1.svg',
                    title: 'Thông tin tài khoản',
                    event: () => Get.toNamed(Routes.taiKhoanCaNhan),
                  ),
                  rowInfo(
                    icon: 'assets/icons/info-2.svg',
                    title: 'Quản lý Linh vật AI',
                    event: () {
                      Get.back();
                      _tabViewModel.goToTab(1);
                    },
                  ),
                  // rowInfo(
                  //   icon: 'assets/icons/info-3.svg',
                  //   title: 'Giới thiệu bạn bè',
                  //   event: () {},
                  // ),
                  rowInfo(
                    icon: 'assets/icons/info-4.svg',
                    title: 'Nạp G vào ví',
                    event: () => Get.toNamed(Routes.napG),
                  ),
                  rowInfo(
                    icon: 'assets/icons/info-5.svg',
                    title: 'Đổi mật khẩu',
                    event: () => Get.toNamed(Routes.changePassword),
                  ),
                  // rowInfoHelp(
                  //   icon: 'assets/icons/info-6.svg',
                  //   title: 'Trợ giúp',
                  //   event: () {},
                  // ),
                  rowInfo(
                    icon: 'assets/icons/info-7.svg',
                    title: 'Đăng xuất',
                    isLogout: true,
                    event: () async => await _infoViewModel.handleLogout(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfoHelp({
    required String icon,
    required String title,
    void Function()? event,
  }) {
    final RxBool isShow = false.obs;

    void handleShow() {
      isShow.value = !isShow.value;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => handleShow(),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF312E2E),
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(icon),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextThemes.text14_400,
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                        'assets/icons/${isShow.value ? 'info-10' : 'info-9'}.svg'),
                  ],
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                    height: isShow.value ? null : 0,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xFF4E4E61),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buttonHelp(
                                icon: 'assets/images/help-1.png', event: () {}),
                            buttonHelp(
                                icon: 'assets/images/help-2.png', event: () {}),
                            buttonHelp(
                                icon: 'assets/images/help-3.png', event: () {}),
                            buttonHelp(
                                icon: 'assets/images/help-4.png', event: () {}),
                            buttonHelp(
                                icon: 'assets/images/help-5.png', event: () {}),
                            buttonHelp(
                                icon: 'assets/images/help-6.png', event: () {}),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buttonHelp({
    required String icon,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Image.asset(icon),
    );
  }

  Widget rowInfo({
    required String icon,
    required String title,
    void Function()? event,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: event,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF312E2E),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextThemes.text14_400.copyWith(
                    color: isLogout ? const Color(0xFFFF6060) : Colors.white),
              ),
              const Spacer(),
              Visibility(
                visible: isLogout == false,
                child: SvgPicture.asset('assets/icons/info-8.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
