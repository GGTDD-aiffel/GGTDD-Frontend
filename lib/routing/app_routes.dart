import 'package:get/get.dart';
import '../ui/user/widgets/user_screen.dart';
import '../ui/user/widgets/user_detail_screen.dart';

class AppRoutes {
  static const String user = '/user';
  static const String userDetail = '/user/detail';

  static final pages = [
    GetPage(name: user, page: () => UserScreen()),
    GetPage(name: userDetail, page: () => UserDetailScreen()),
  ];

  static String get initial => user;
}
