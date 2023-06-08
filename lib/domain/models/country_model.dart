class Country {
  String? id;
  String? twoLetterAbbreviation;
  String? threeLetterAbbreviation;
  String? fullNameLocale;
  String? fullNameEnglish;

  Country(
      {this.id,
      this.twoLetterAbbreviation,
      this.threeLetterAbbreviation,
      this.fullNameLocale,
      this.fullNameEnglish});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    twoLetterAbbreviation = json['two_letter_abbreviation'];
    threeLetterAbbreviation = json['three_letter_abbreviation'];
    fullNameLocale = json['full_name_locale'];
    fullNameEnglish = json['full_name_english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['two_letter_abbreviation'] = twoLetterAbbreviation;
    data['three_letter_abbreviation'] = threeLetterAbbreviation;
    data['full_name_locale'] = fullNameLocale;
    data['full_name_english'] = fullNameEnglish;
    return data;
  }
}
