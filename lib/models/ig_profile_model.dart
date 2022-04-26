class IgProfileModel {

  String profilePicUrl;
  String profilePicUrlHd;

  IgProfileModel({required this.profilePicUrl, required this.profilePicUrlHd});


  factory IgProfileModel.fromJson(Map<String, dynamic> json) => IgProfileModel(
    profilePicUrl: json['graphql']['user']['profile_pic_url'],
    profilePicUrlHd: json['graphql']['user']['profile_pic_url_hd'],
  );

  Map<String, dynamic> toJson() => {};


}