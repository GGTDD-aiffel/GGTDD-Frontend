import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSimpleAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomSimpleAppBar({
    super.key,
    required this.title,
  });

  static final Map<String, String> routeTitles = {
    '/': '홈',
    '/intro': '소개',
    '/welcome': '환영',
    '/onboarding/info': '유저 정보 입력',
    '/onboarding/contexts': '직업별 기본 맥락',
    '/inbox': '수집',
    '/recognition': '구체화',
    '/actions': '액션',
    '/actions/': '액션 상세',
    '/settings': '설정',
    '/settings/user_info': '유저 정보',
    '/settings/context_tags': '맥락 태그',
    '/settings/context_tags/context': '맥락 규칙',
    '/settings/context_tags/tags': '유저 정의 태그',
    '/settings/app_features': '일반 기능',
    '/settings/timer': '타이머',
    '/focus/': '집중',
  };

  String? getPreviousPageTitle() {
    final previousRoute = Get.previousRoute;
    String? title;
    final sortedRoutes = routeTitles.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    for (var route in sortedRoutes) {
      if (previousRoute.startsWith(route)) {
        title = routeTitles[route];
        break;
      }
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    final previousTitle = getPreviousPageTitle();
    final canPop = Navigator.canPop(context);
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: previousTitle != null && canPop ? 120.0 : 56.0,
      leading: canPop
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                if (previousTitle != null)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 60),
                    child: Text(
                      previousTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
