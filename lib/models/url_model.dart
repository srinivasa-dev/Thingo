

class UrlModel {
  String shortLink;
  String fullShortLink;
  String shortLink2;
  String fullShortLink2;
  String shortLink3;
  String fullShortLink3;

  UrlModel({required this.shortLink, required this.fullShortLink, required this.shortLink2, required this.fullShortLink2, required this.shortLink3, required this.fullShortLink3});

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(
    shortLink: json['short_link'],
    fullShortLink: json['full_short_link'],
    shortLink2: json['short_link2'],
    fullShortLink2: json['full_short_link2'],
    shortLink3: json['short_link3'],
    fullShortLink3: json['full_short_link3'],
  );

  Map<String, dynamic> toJson() => {};

}