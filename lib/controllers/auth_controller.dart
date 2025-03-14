import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final RxString userId = '1'.obs;

  void setUserId(String id) {
    userId.value = id;
  }
}
