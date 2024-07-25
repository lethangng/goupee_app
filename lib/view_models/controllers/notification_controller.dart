import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/notification_service.dart';

class NotificationController extends GetxController {
  void pushNotification() {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      await NotificationService.showNotification(
        title: "Title of the notification",
        body: "Body of the notification",
        payload: {
          "navigate": "true",
        },
        actionButtons: [
          NotificationActionButton(
            key: 'check',
            label: 'Khám phá',
            actionType: ActionType.SilentAction,
            color: Colors.green,
          )
        ],
      );
    });
  }

  @override
  void onInit() {
    // pushNotification();
    super.onInit();
  }
}
