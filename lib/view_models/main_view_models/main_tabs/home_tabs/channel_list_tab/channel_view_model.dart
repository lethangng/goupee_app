import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/home_models/channel_item_model.dart';
import '../../../../../models/login_models/request_data.dart';
import '../../../../../services/repository/access_server_repository.dart';
import '../../../../../services/response/api_response.dart';
import '../../../../controllers/app_data_controller.dart';

class ChannelViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AppDataController _appDataController = Get.find<AppDataController>();
  late TabController tabController;
  late ChannelInfo channelInfo;
  late RxBool isFollow;

  final Rx<ApiResponse<bool>> followRes = ApiResponse<bool>.completed(null).obs;
  final AccessServerRepository _accessServerRepository =
      AccessServerRepository();

  void setFollowRes(ApiResponse<bool> res) {
    followRes.value = res;
  }

  Future<void> _fetchDataFollow(RequestData req) async {
    setFollowRes(ApiResponse.loading());
    try {
      await _accessServerRepository.postData(req.toMap());
      isFollow.value = !isFollow.value;

      // Xoa/Them cac channel trong appData
      if (_appDataController.appDataRes.value.data!.follow_channels
          .contains(channelInfo.id)) {
        _appDataController.appDataRes.value.data!.follow_channels
            .remove(channelInfo.id);
      } else {
        _appDataController.appDataRes.value.data!.follow_channels
            .add(channelInfo.id);
      }

      setFollowRes(ApiResponse.completed(true));
    } catch (e, s) {
      s.printError();
      setFollowRes(ApiResponse.error(e.toString()));
    }
  }

  Future<void> handleFollow() async {
    Map<String, dynamic> data = {
      'channel_id': channelInfo.id,
    };

    RequestData resquestData = RequestData(
      query: 'update_follow',
      data: json.encode(data),
    );

    await _fetchDataFollow(resquestData);
  }

  @override
  void onInit() {
    final String? paramValue = Get.arguments['channelInfo'];
    if (paramValue != null) {
      channelInfo = ChannelInfo.fromJson(paramValue);
    }

    if (_appDataController.appDataRes.value.data!.follow_channels
        .contains(channelInfo.id)) {
      isFollow = true.obs;
      setFollowRes(ApiResponse.completed(true));
    } else {
      isFollow = false.obs;
      setFollowRes(ApiResponse.completed(true));
    }

    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.animateTo(0);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
