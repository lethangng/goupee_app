import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../models/table/user.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/text_themes.dart';
import '../../../../../view_models/main_view_models/main_tabs/my_channel_tabs/tabs/my_gioi_thieu_tab.dart';
import '../../../../widgets/avatar_container.dart';
import '../../../../widgets/show_dialog_error.dart';

class MyChannelInfoTab extends StatelessWidget {
  MyChannelInfoTab({super.key});
  final MyGioiThieuTab _myInfoTab = Get.put(MyGioiThieuTab());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_myInfoTab.userRes.value.status == Status.error) {
        showDialogError(error: _myInfoTab.userRes.value.message!);
      }

      if (_myInfoTab.userRes.value.status == Status.completed) {
        User userInfo = _myInfoTab.userRes.value.data!;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible:
                    userInfo.description != null && userInfo.description != '',
                child: Text(
                  userInfo.description ?? '',
                  style: TextThemes.text14_400,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarContainer(
                    radius: 40,
                    image: userInfo.image,
                    replaceImage: 'assets/images/teacher.png',
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tác giả: ${userInfo.fullname}',
                        style: TextThemes.text14_500,
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          userInfo.archieve_des ?? '',
                          style: TextThemes.text14_400.copyWith(
                            color: const Color(0xFFE0E0E6),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 8),
                      // rowContainerHH(
                      //   image: 'assets/icons/huy-hieu-1.svg',
                      //   title: 'Sáng kiến kinh nghiệm đạt loại B TP Hà Nội',
                      // ),
                      // const SizedBox(height: 8),
                      // rowContainerHH(
                      //   image: 'assets/icons/huy-hieu-2.svg',
                      //   title: 'Sáng kiến kinh nghiệm đạt loại B TP Hà Nội',
                      // ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }

  Widget rowContainerHH({required String image, required String title}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0E0E6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
