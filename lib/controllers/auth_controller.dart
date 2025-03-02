import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxString userName = ''.obs;

  void login(String username, String password) {
    // Simulate login (replace with actual API call, e.g., Firebase, OAuth)
    isLoggedIn.value = true;
    userName.value = username;
    Get.snackbar('Success', 'Logged in as $username');
  }

  void logout() {
    isLoggedIn.value = false;
    userName.value = '';
    Get.snackbar('Success', 'Logged out');
  }
}