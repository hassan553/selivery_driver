class RentCarModel {
  String? userId;
  String? ownerName;
  String? phone;
  String? facebookLink;
  String? telegramLink;
  Car? car;
  int? price;
  List<String>? rentRequirements;
  bool? withDriver;
  String? publishDate;
  String? sId;
  int? iV;

  RentCarModel(
      {this.userId,
        this.ownerName,
        this.phone,
        this.facebookLink,
        this.telegramLink,
        this.car,
        this.price,
        this.rentRequirements,
        this.withDriver,
        this.publishDate,
        this.sId,
        this.iV});

  RentCarModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    ownerName = json['ownerName'];
    phone = json['phone'];
    facebookLink = json['facebookLink'];
    telegramLink = json['telegramLink'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    price = json['price'];
    rentRequirements = json['rentRequirements'].cast<String>();
    withDriver = json['withDriver'];
    publishDate = json['publishDate'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['ownerName'] = ownerName;
    data['phone'] = phone;
    data['facebookLink'] = facebookLink;
    data['telegramLink'] = telegramLink;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['price'] = price;
    data['rentRequirements'] = rentRequirements;
    data['withDriver'] = withDriver;
    data['publishDate'] = publishDate;
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

class Car {
  List<String>? images;
  String? sId;
  String? type;
  String? description;
  String? category;

  Car({this.images, this.sId, this.type, this.description, this.category});

  Car.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    sId = json['_id'];
    type = json['type'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    data['_id'] = sId;
    data['type'] = type;
    data['description'] = description;
    data['category'] = category;
    return data;
  }
}