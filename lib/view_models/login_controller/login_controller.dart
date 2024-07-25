import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/routes.dart';
import '../../models/table/user.dart';
import '../../services/response/api_response.dart';
import '../controllers/user_controller.dart';

class LoginController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final Rx<ApiResponse<bool>> checkLogin = ApiResponse<bool>.loading().obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void setCheckLogin(ApiResponse<bool> value) {
    checkLogin.value = value;
  }

  // Google
  Future<void> loginGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      User user = toMapUserGoogle(account);
      userController.setUserRes(ApiResponse.completed(user));
      setCheckLogin(ApiResponse.completed(null));
      await Get.offAllNamed(Routes.home);
    } else {
      //
    }
  }

  Future<bool> checkIfIsLoggedGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
    if (account != null) {
      debugPrint('login google $account');
      User user = toMapUserGoogle(account);
      userController.setUserRes(ApiResponse.completed(user));
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    if (await checkIfIsLoggedGoogle()) {
      await _googleSignIn.disconnect();
    } else if (await checkIfIsLoggedFacebook()) {
      await FacebookAuth.instance.logOut();
    } else {
      //
    }
  }

  User toMapUserGoogle(GoogleSignInAccount account) {
    return User(
      id: 1,
      fullname: account.displayName as String,
      email: account.email,
      image: account.photoUrl as String,
      login_type: 'google',
    );
  }

  // Facebook
  Future<bool> checkIfIsLoggedFacebook() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      final userDataValue = await FacebookAuth.instance.getUserData();
      debugPrint('login facebook $userDataValue');
      User user = toMapUserFacebook(userDataValue);
      userController.setUserRes(ApiResponse.completed(user));
      return true;
    } else {
      return false;
    }
  }

  User toMapUserFacebook(Map map) {
    return User(
      id: 1,
      fullname: map['name'] as String,
      email: map['email'] as String,
      image: map['picture']['data']['url'] as String,
      login_type: 'facebook',
    );
  }

  Future<void> loginFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userDataValue = await FacebookAuth.instance.getUserData();
      User user = toMapUserFacebook(userDataValue);
      userController.setUserRes(ApiResponse.completed(user));
      setCheckLogin(ApiResponse.completed(null));
      await Get.offAllNamed(Routes.home);
    } else {
      //
    }
  }
}
