import 'package:foodguru/app_values/export.dart';

class TranslationService extends Translations{
  static Locale? get locale =>PreferenceManger().getLanguage()?? Get.deviceLocale;
  static const fallbackLocale = Locale('en');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'hi_IN': hi_IN,
  };
}