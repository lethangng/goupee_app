import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';
import 'package:goup_app/views/widgets/avatar_container.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../app/routes.dart';
import '../../../../../../models/table/user.dart';
import '../../../../../../services/response/api_status.dart';
import '../../../../../../utils/color_app.dart';
import '../../../../../../view_models/controllers/user_controller.dart';
import '../../../../../../view_models/main_view_models/main_tabs/menu/info_views/info/tai_khoan_ca_nhan_view_model.dart';
import '../../../../../widgets/button_primary.dart';
import '../../../../../widgets/show_dialog_error.dart';

class TaiKhoanCaNhanScreen extends StatelessWidget {
  TaiKhoanCaNhanScreen({super.key});
  final User _userInfo = Get.find<UserController>().userRes.value.data!;
  final TaiKhoanCaNhanViewModel _taiKhoanCaNhanViewModel =
      Get.put(TaiKhoanCaNhanViewModel());

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    printInfo(info: returnedImage.path);
    _taiKhoanCaNhanViewModel.setSelectImage(File(returnedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18191A),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Tài khoản cá nhân',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ảnh đại diện:',
                        style: TextThemes.text16_500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Stack(
                      children: [
                        GestureDetector(
                          onTap: () async => await _pickImageFromGallery(),
                          child: Container(
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: _taiKhoanCaNhanViewModel
                                        .selectedImage.value ==
                                    null
                                ? AvatarContainer(
                                    image: _userInfo.image,
                                    radius: 200,
                                    replaceImage: 'assets/images/avatar-7.png',
                                  )
                                : ClipOval(
                                    child: Image.file(
                                      _taiKhoanCaNhanViewModel
                                          .selectedImage.value!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:
                                SvgPicture.asset('assets/icons/subtract.svg'),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child:
                                  SvgPicture.asset('assets/icons/camera-2.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23.5),
                  Obx(
                    () => rowInfo(
                      title: 'Tên tài khoản',
                      value: _taiKhoanCaNhanViewModel.fullname.value,
                      isEdit: true,
                      event: () => Get.toNamed(Routes.editInfo, arguments: {
                        'editType': EditType.fullname,
                        'editTitle': 'Tên tài khoản',
                        'editValue': _taiKhoanCaNhanViewModel.fullname.value,
                      }),
                    ),
                  ),
                  Obx(
                    () => rowInfo(
                      title: 'ID kênh cá nhân',
                      value: _taiKhoanCaNhanViewModel.channelTitle.value,
                      isEdit: true,
                      event: () => Get.toNamed(Routes.editInfo, arguments: {
                        'editType': EditType.channleTitle,
                        'editTitle': 'ID kênh cá nhân',
                        'editValue':
                            _taiKhoanCaNhanViewModel.channelTitle.value,
                      }),
                    ),
                  ),
                  rowInfo(
                    title: 'Số điện thoại',
                    value: '${_userInfo.phone}',
                    isEdit: false,
                    event: () {},
                  ),
                  rowInfo(
                    title: 'Email',
                    value: '${_userInfo.email}',
                    isEdit: false,
                    event: () {},
                  ),
                  rowInfo(
                    title: 'Số dư',
                    value: '${_userInfo.g_points} G',
                    isEdit: false,
                    event: () {},
                  ),
                  rowInfo(
                    title: 'Tổng nạp',
                    value: '${_userInfo.total_recharge} G',
                    isEdit: false,
                    event: () {},
                  ),
                  Obx(
                    () => rowInfo(
                      title: 'Nghề nghiệp',
                      value: _taiKhoanCaNhanViewModel.job.value,
                      isEdit: true,
                      isLongInfo: true,
                      event: () => Get.toNamed(Routes.editInfo, arguments: {
                        'editType': EditType.job,
                        'editTitle': 'Nghề nghiệp',
                        'editValue': _taiKhoanCaNhanViewModel.job.value,
                      }),
                    ),
                  ),
                  Obx(
                    () => rowInfo(
                      title: 'Thành tích',
                      value: _taiKhoanCaNhanViewModel.archieve.value,
                      isEdit: true,
                      isLongInfo: true,
                      event: () => Get.toNamed(Routes.editInfo, arguments: {
                        'editType': EditType.archieve,
                        'editTitle': 'Thành tích',
                        'editValue': _taiKhoanCaNhanViewModel.archieve.value,
                      }),
                    ),
                  ),
                  Obx(
                    () => rowInfo(
                      title: 'Giới thiệu',
                      value: _taiKhoanCaNhanViewModel.description.value,
                      isEdit: true,
                      isLongInfo: true,
                      event: () => Get.toNamed(Routes.editInfo, arguments: {
                        'editType': EditType.description,
                        'editTitle': 'Giới thiệu',
                        'editValue': _taiKhoanCaNhanViewModel.description.value,
                      }),
                    ),
                  ),
                  const SizedBox(height: 29),
                  Obx(() {
                    if (_taiKhoanCaNhanViewModel.updateUserRes.value.status ==
                        Status.error) {
                      showDialogError(
                        error: _taiKhoanCaNhanViewModel
                            .updateUserRes.value.message!,
                      );
                    }
                    if (_taiKhoanCaNhanViewModel.uploadImageRes.value.status ==
                        Status.error) {
                      showDialogError(
                        error: _taiKhoanCaNhanViewModel
                            .uploadImageRes.value.message!,
                      );
                    }

                    if (_taiKhoanCaNhanViewModel.updateUserRes.value.status ==
                        Status.completed) {
                      return ButtonPrimary(
                        title: 'Cập nhật',
                        event: () =>
                            _taiKhoanCaNhanViewModel.handleUpdateUser(),
                      );
                    }
                    return const Center(
                      child: SizedBox(
                        width: 40,
                        child: CircularProgressIndicator(
                          color: ColorApp.colorOrange,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
    bool isEdit = false,
    bool isLongInfo = false,
    void Function()? event,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: event,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                '$title:',
                style: TextThemes.text14_500.copyWith(
                  color: const Color(0xFFC1C1CD),
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: isLongInfo ? TextAlign.start : TextAlign.end,
                style: TextThemes.text14_400,
              ),
            ),
            const SizedBox(width: 8),
            Visibility(
              visible: isEdit,
              maintainSize: false,
              child: SvgPicture.asset('assets/icons/info-8.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
