class UserSettings {
  final String userSettingId;
  final String userId;
  final bool introPageEnabled;
  final bool landingPageEnabled;
  final bool focusPageEnabled;
  final String theme;
  final String language;
  final String font;

  UserSettings({
    required this.userSettingId,
    required this.userId,
    required this.introPageEnabled,
    required this.landingPageEnabled,
    required this.focusPageEnabled,
    required this.theme,
    required this.language,
    required this.font,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      userSettingId: json['user_setting_id'] as String,
      userId: json['user_id'] as String,
      introPageEnabled: json['intro_page_enabled'] as bool,
      landingPageEnabled: json['landing_page_enabled'] as bool,
      focusPageEnabled: json['focus_page_enabled'] as bool,
      theme: json['theme'] as String,
      language: json['language'] as String,
      font: json['font'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_setting_id': userSettingId,
      'user_id': userId,
      'intro_page_enabled': introPageEnabled,
      'landing_page_enabled': landingPageEnabled,
      'focus_page_enabled': focusPageEnabled,
      'theme': theme,
      'language': language,
      'font': font,
    };
  }
}
