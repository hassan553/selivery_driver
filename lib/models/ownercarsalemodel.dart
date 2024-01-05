class OwnerModel {
  Rating? rating;
  String? sId;
  String? name;
  String? gender;
  int? age;
  String? email;
  bool? verified;
  String? image;
  int? status;
  bool? available;

  OwnerModel(
      {this.rating,
        this.sId,
        this.name,
        this.gender,
        this.age,
        this.email,
        this.verified,
        this.image,
        this.status,
        this.available});

  OwnerModel.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    sId = json['_id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    email = json['email'];
    verified = json['verified'];
    image = json['image'];
    status = json['status'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['email'] = email;
    data['verified'] = verified;
    data['image'] = image;
    data['status'] = status;
    data['available'] = available;
    return data;
  }
}

class Rating {
  int? cool;
  int? good;
  int? fair;

  Rating({this.cool, this.good, this.fair});

  Rating.fromJson(Map<String, dynamic> json) {
    cool = json['cool'];
    good = json['good'];
    fair = json['fair'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cool'] = cool;
    data['good'] = good;
    data['fair'] = fair;
    return data;
  }
}