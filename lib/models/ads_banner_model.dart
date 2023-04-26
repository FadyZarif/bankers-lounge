class AdsBannerModel{
  String? bannerImgUrl;
  String? bannerWebUrl;
  String? dateTime;

  AdsBannerModel({
   this.bannerImgUrl,
   this.bannerWebUrl,
   this.dateTime,
  });

  AdsBannerModel.fromJson(Map<String,dynamic>json){
    bannerImgUrl = json['bannerImgUrl'];
    bannerWebUrl = json['bannerWebUrl'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toJson(){
    return {
      'bannerImgUrl' : bannerImgUrl,
      'bannerWebUrl' : bannerWebUrl,
      'dateTime' : dateTime,
    };
  }


}