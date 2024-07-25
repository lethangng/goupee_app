import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../models/login_models/request_data.dart';
import '../../../../../../models/table/user.dart';
import '../../../../../../models/upload/upload_file_model.dart';
import '../../../../../../services/repository/access_server_repository.dart';
import '../../../../../../services/response/api_response.dart';
import '../../../../../../utils/validate.dart';
import '../../../../../controllers/user_controller.dart';

enum EditType {
  fullname,
  channleTitle,
  job,
  archieve,
  description,
}

class TaiKhoanCaNhanViewModel extends GetxController {
  late final User userInfo;
  final Rx<ApiResponse<bool>> updateUserRes =
      ApiResponse<bool>.completed(true).obs;

  final Rx<ApiResponse<bool>> uploadImageRes =
      ApiResponse<bool>.completed(true).obs;

  final UserController _userController = Get.find<UserController>();
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  final Rx<File?> selectedImage = Rx<File?>(null);

  late final RxString fullname;
  late final RxString channelTitle;
  late final RxString job;
  late final RxString archieve;
  late final RxString description;

  void setSelectImage(File value) {
    selectedImage.value = value;
  }

  void setUpdateUserRes(ApiResponse<bool> res) {
    updateUserRes.value = res;
  }

  void setUploadImageRes(ApiResponse<bool> res) {
    uploadImageRes.value = res;
  }

  Future<void> _fetchData(RequestData req) async {
    setUpdateUserRes(ApiResponse.loading());
    try {
      await _accessServerRepository.postData(req.toMap());

      // Update lai userInfo cua UserController
      userInfo.fullname = fullname.value;
      userInfo.channel_title = channelTitle.value;
      userInfo.job_des = job.value;
      userInfo.archieve_des = archieve.value;
      userInfo.description = description.value;

      _userController.setUserRes(ApiResponse.completed(userInfo));

      setUpdateUserRes(ApiResponse.completed(true));
      Get.snackbar(
        'Thông báo',
        'Cập nhập thành công.',
        icon: const Icon(Icons.check, color: Colors.green),
        colorText: Colors.white,
        // backgroundColor: const Color(0xFF312E2E),
      );
    } catch (e, s) {
      s.printError();
      setUpdateUserRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUpdateUser() async {
    if (userInfo.fullname == fullname.value &&
        userInfo.channel_title == channelTitle.value &&
        userInfo.job_des == job.value &&
        userInfo.archieve_des == archieve.value &&
        userInfo.description == description.value &&
        selectedImage.value == null) {
      Get.snackbar(
        'Thông báo',
        'Vui lòng thay đổi thông tin trước khi nhấn cập nhập.',
        icon: const Icon(Icons.error, color: Colors.red),
        colorText: Colors.white,
        // backgroundColor: const Color(0xFF312E2E),
      );
      return;
    }

    if (selectedImage.value != null) {
      await handleUploadImage();
    }

    Map<String, dynamic> data = {
      'fullname': fullname.value,
      'channel_title': channelTitle.value,
      'image': userInfo.image,
      'job_des': job.value,
      'archieve_des': archieve.value,
      'description': description.value,
    };

    RequestData resquestData = RequestData(
      query: 'user_update',
      data: json.encode(data),
    );

    await _fetchData(resquestData);
  }

  Future<void> _uploadData(UploadFileModel req) async {
    setUploadImageRes(ApiResponse.loading());
    try {
      final String res = await _accessServerRepository.uploadFile(req);

      // Update lai userInfo cua UserController
      userInfo.image = '${Configs.domain}/$res';

      // _userController.setUserRes(ApiResponse.completed(userInfo));

      setUploadImageRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setUploadImageRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleUploadImage() async {
    Map<String, dynamic> data = {
      //
    };

    RequestData requestData = RequestData(
      query: 'upload_image',
      data: json.encode(data),
    );

    UploadFileModel uploadFileModel = UploadFileModel(
      requestData: requestData.toMap(),
      file: selectedImage.value!,
    );

    await _uploadData(uploadFileModel);
  }

  @override
  void onInit() {
    userInfo = _userController.userRes.value.data!;
    fullname = userInfo.fullname.obs;
    channelTitle = Validate.checkNullEmpty(userInfo.channel_title)
        ? userInfo.channel_title!.obs
        : ''.obs;
    job = Validate.checkNullEmpty(userInfo.job_des)
        ? userInfo.job_des!.obs
        : ''.obs;
    archieve = Validate.checkNullEmpty(userInfo.archieve_des)
        ? userInfo.archieve_des!.obs
        : ''.obs;
    description = Validate.checkNullEmpty(userInfo.description)
        ? userInfo.description!.obs
        : ''.obs;
    super.onInit();
  }
}
