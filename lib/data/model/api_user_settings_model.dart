import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_setting_model.dart';

// 유저 설정 조회 응답 DTO (추가)
class UserSettingsResponse {
  final UserSettings settings;

  UserSettingsResponse({required this.settings});

  factory UserSettingsResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserSettingsResponse(
      settings: UserSettings.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return settings.toJson();
  }
}

// 유저 설정 수정 요청 DTO
class UserSettingsUpdateRequest {
  final bool? introPageEnabled;
  final bool? landingPageEnabled;
  final bool? focusPageEnabled;
  final String? theme;
  final String? language;
  final String? font;

  UserSettingsUpdateRequest({
    this.introPageEnabled,
    this.landingPageEnabled,
    this.focusPageEnabled,
    this.theme,
    this.language,
    this.font,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (introPageEnabled != null) data['intro_page_enabled'] = introPageEnabled;
    if (landingPageEnabled != null)
      data['landing_page_enabled'] = landingPageEnabled;
    if (focusPageEnabled != null) data['focus_page_enabled'] = focusPageEnabled;
    if (theme != null) data['theme'] = theme;
    if (language != null) data['language'] = language;
    if (font != null) data['font'] = font;
    return data;
  }
}

// BaseResponse 적용
typedef UserSettingsResponseDto = BaseResponse<UserSettingsResponse>;
typedef UserSettingsCreateResponse = BaseResponse<UserSettings>;
typedef UserSettingsUpdateResponse = BaseResponse<UserSettings>;
typedef UserSettingsDeleteResponse = BaseResponse<void>;
