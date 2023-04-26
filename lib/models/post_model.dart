
class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postText;
  String? postImage;
  String? postUrl;


  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postText,
    this.postImage,
    this.postUrl,

  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postText = json['postText'];
    postImage = json['postImage'];
    postUrl = json['postUrl'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postText': postText,
      'postImage': postImage,
      'postUrl': postUrl,

    };
  }
}
