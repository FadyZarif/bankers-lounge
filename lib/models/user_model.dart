class UserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? token;
  String? role;
  String? city;

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.phone,
    this.image,
    this.token,
    this.role,
    this.city,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    role = json['role'];
    city = json['city'];

  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'image': image,
      'token': token,
      'role': role,
      'city': city,
    };
  }
}
