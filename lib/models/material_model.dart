class MaterialModel{
  int? order;
  String? name;
  bool? isPdf;
  String? url;

  MaterialModel({this.order, this.name, this.isPdf, this.url});

  MaterialModel.fromJson(Map<String,dynamic> json){
    order = json['order'];
    name = json['name'];
    isPdf = json['isPdf'];
    url = json['url'];
  }

  Map<String, dynamic> toJson(){
    return {
    'order' : order,
    'name' : name,
    'isPdf' : isPdf,
    'url' : url
    };
  }

}