import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../models/home_models/top_channel_model.dart';
import '../../../../../models/table/user.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/text_themes.dart';
import '../../../../../view_models/controllers/user_controller.dart';
import '../../../../../view_models/tab_view_models/channel_tabs/top_channel_controller.dart';
import '../../../../widgets/avatar_container.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class TopChannelTab extends StatelessWidget {
  TopChannelTab({super.key});
  final TopChannelController _topChannelController =
      Get.put(TopChannelController());
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_topChannelController.topChannelRes.value.status == Status.error) {
        showDialogError(
          error: _topChannelController.topChannelRes.value.message!,
        );
      }

      if (_topChannelController.topChannelRes.value.status ==
              Status.completed &&
          _topChannelController.listData.isNotEmpty) {
        User userInfo = _userController.userRes.value.data!;
        return Stack(
          children: [
            Loadmore(
              refreshController: _topChannelController.refreshController,
              onLoading: _topChannelController.onLoading,
              onRefresh: _topChannelController.onRefresh,
              widget: screen(),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: const Color(0xFFFF5810).withOpacity(0.5),
                      ),
                      color: const Color(0xFFFFB380),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _topChannelController.currentRanking.value
                                  .toString(),
                              textAlign: TextAlign.end,
                              style: TextThemes.text14_600
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(width: 6),
                            AvatarContainer(
                              image: userInfo.image,
                              replaceImage: 'assets/images/bxh-avatar-2.png',
                              radius: 36,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              userInfo.fullname,
                              style: TextThemes.text14_500
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${userInfo.total_favourites}',
                              style: TextThemes.text14_600
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset('assets/icons/heart-icon.svg'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }

  Widget screen() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/images/bxh.svg',
                    width: Get.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 40,
                            ),
                            child: columnInfo(
                              size: 50,
                              channelRanking: _topChannelController.listData[1],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: columnInfo(
                              size: 60,
                              channelRanking:
                                  _topChannelController.listData.first,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 60,
                            ),
                            child: columnInfo(
                              size: 50,
                              channelRanking: _topChannelController.listData[2],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 270),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/bxh-2.svg',
                          width: Get.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            color: const Color(0xFF312E2E),
                            child: ListView.builder(
                              itemCount:
                                  _topChannelController.listData.length - 3,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 90,
                              ),
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return bxhRow(
                                  index: index + 4,
                                  channelRanking:
                                      _topChannelController.listData[index + 3],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bxhRow({
    required int index,
    required ChannelRanking channelRanking,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF3F3F40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$index',
                  textAlign: TextAlign.end,
                  style: TextThemes.text14_600,
                ),
                const SizedBox(width: 6),
                AvatarContainer(
                  image: channelRanking.user_image,
                  replaceImage: 'assets/images/bxh-avatar-2.png',
                  radius: 36,
                ),
                const SizedBox(width: 6),
                Text(
                  channelRanking.user_fullname,
                  style: TextThemes.text14_500,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${channelRanking.total_favourites}',
                  style: TextThemes.text14_600,
                ),
                const SizedBox(width: 4),
                SvgPicture.asset('assets/icons/heart-icon.svg'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget columnInfo({
    required double size,
    required ChannelRanking channelRanking,
  }) {
    return Column(
      children: [
        AvatarContainer(
          image: channelRanking.user_image,
          replaceImage: 'assets/images/bxh-avatar-2.png',
          radius: size,
        ),
        const SizedBox(height: 7),
        Text(
          channelRanking.user_fullname.length > 10
              ? '${channelRanking.user_fullname.substring(0, 10)}...'
              : channelRanking.user_fullname,
          style:
              TextThemes.text14_600.copyWith(overflow: TextOverflow.ellipsis),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${channelRanking.total_favourites}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset('assets/icons/heart-icon.svg'),
          ],
        )
      ],
    );
  }
}
