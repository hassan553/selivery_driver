class RequestTripsModel {
  PickupLocation? pickupLocation;
  String? sId;
  Passenger? passenger;
  String? driver;
  PickupLocation? destinationLocation;
  String? status;
  int? fare;
  String? date;

  RequestTripsModel(
      {this.pickupLocation,
        this.sId,
        this.passenger,
        this.driver,
        this.destinationLocation,
        this.status,
        this.fare,
        this.date});

  RequestTripsModel.fromJson(Map<String, dynamic> json) {
    pickupLocation = json['pickupLocation'] != null
        ? PickupLocation.fromJson(json['pickupLocation'])
        : null;
    sId = json['_id'];
    passenger = json['passenger'] != null
        ? Passenger.fromJson(json['passenger'])
        : null;
    driver = json['driver'];
    destinationLocation = json['destinationLocation'] != null
        ? PickupLocation.fromJson(json['destinationLocation'])
        : null;
    status = json['status'];
    fare = json['fare'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pickupLocation != null) {
      data['pickupLocation'] = pickupLocation!.toJson();
    }
    data['_id'] = sId;
    if (passenger != null) {
      data['passenger'] = passenger!.toJson();
    }
    data['driver'] = driver;
    if (destinationLocation != null) {
      data['destinationLocation'] = destinationLocation!.toJson();
    }
    data['status'] = status;
    data['fare'] = fare;
    data['date'] = date;
    return data;
  }
}

class PickupLocation {
  String? type;
  List<double>? coordinates;

  PickupLocation({this.type, this.coordinates});

  PickupLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Passenger {
  String? sId;
  String? name;
  String? gender;
  int? age;
  String? email;
  bool? verified;
  String? password;
  String? image;
  String? role;
  bool? available;
  String? deviceToken;
  int? iV;

  Passenger(
      {this.sId,
        this.name,
        this.gender,
        this.age,
        this.email,
        this.verified,
        this.password,
        this.image,
        this.role,
        this.available,
        this.deviceToken,
        this.iV});

  Passenger.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    email = json['email'];
    verified = json['verified'];
    password = json['password'];
    image = json['image'];
    role = json['role'];
    available = json['available'];
    deviceToken = json['deviceToken'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    data['email'] = email;
    data['verified'] = verified;
    data['password'] = password;
    data['image'] = image;
    data['role'] = role;
    data['available'] = available;
    data['deviceToken'] = deviceToken;
    data['__v'] = iV;
    return data;
  }
}