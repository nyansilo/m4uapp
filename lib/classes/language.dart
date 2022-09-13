class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String countryCode;

  Language(this.id, this.flag, this.name, this.languageCode, this.countryCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en", "us"),
      Language(2, "🇹🇿", "Swahili", "sw", "tz"),
      Language(3, "🇨🇳", "Chinese", "zh", "cn"),
      Language(4, "🇸🇦", "Arabic", "ar", "sa"),
      Language(5, "🇮🇳", "Hindi", "hi", "in")
    ];
  }
}
