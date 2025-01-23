enum LanguageType { ENGLISH, ARABIC, VIETNAM }

const String ENGLISH = "en";
const String ARABIC = "ar";
const String VIETNAM = "vn";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
      case LanguageType.VIETNAM:
        return VIETNAM;
    }
  }
}
