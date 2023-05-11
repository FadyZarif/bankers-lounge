class MaterialModel{
  int? order;
  String? name;
  bool? isPdf;
  bool? isVideo;
  String? url;

  MaterialModel({this.order, this.name, this.isPdf=true, this.url,this.isVideo=false});

  MaterialModel.fromJson(Map<String,dynamic> json){
    order = json['order'];
    name = json['name'];
    isPdf = json['isPdf'];
    isVideo = json['isVideo'];
    url = json['url'];
  }

  Map<String, dynamic> toJson(){
    return {
    'order' : order,
    'name' : name,
    'isPdf' : isPdf,
    'isVideo' : isVideo,
    'url' : url
    };
  }

}