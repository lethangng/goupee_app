import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/table/user.dart';

class FacebookLoginViewModel extends GetxController {
  final RxBool checking = true.obs;
  final Rx<User?> userData = Rx<User?>(null);
  // AccessToken? accessToken;

  Future<void> checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      final userDataValue = await FacebookAuth.instance.getUserData();
      userData.value = toMapUser(userDataValue);
      // this.accessToken = accessToken;
      print('login facebook ${userData.value}');
      Get.toNamed(Routes.home);
    } else {
      //
    }
    checking.value = false;
  }

  User toMapUser(Map map) {
    return User(
      id: 1,
      fullname: map['name'] as String,
      email: map['email'] as String,
      image: map['picture']['data']['url'] as String,
      login_type: 'facebook',
    );
  }

  Future<void> login() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // accessToken = result.accessToken;
      final userDataValue = await FacebookAuth.instance.getUserData();
      userData.value = toMapUser(userDataValue);
    } else {
      // print(result.status);
      // print(result.message);
    }
    checking.value = false;
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
    // accessToken = null;
    userData.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    checkIfIsLogged();
  }
}
