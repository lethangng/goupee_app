import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/routes.dart';
import '../../models/table/user.dart';

// GoogleUserCircleAvatar (hien thi avatar)
class GoogleLoginViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final Rx<User?> userData = Rx<User?>(null);
  final RxBool checking = true.obs;

  Future<void> login() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      userData.value = toMapUser(account);
    }
    checking.value = false;
  }

  Future<void> checkIfIsLogged() async {
    final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
    if (account != null) {
      userData.value = toMapUser(account);
      print('login google $account');
      Get.toNamed(Routes.home);
    } else {
      //
    }
    checking.value = false;
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    userData.value = null;
  }

  User toMapUser(GoogleSignInAccount account) {
    return User(
      id: 1,
      fullname: account.displayName as String,
      email: account.email,
      image: account.photoUrl as String,
    );
  }

  @override
  void onInit() {
    super.onInit();
    checkIfIsLogged();
  }
}
