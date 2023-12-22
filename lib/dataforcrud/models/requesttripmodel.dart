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
        ? new PickupLocation.fromJson(json['pickupLocation'])
        : null;
    sId = json['_id'];
    passenger = json['passenger'] != null
        ? new Passenger.fromJson(json['passenger'])
        : null;
    driver = json['driver'];
    destinationLocation = json['destinationLocation'] != null
        ? new PickupLocation.fromJson(json['destinationLocation'])
        : null;
    status = json['status'];
    fare = json['fare'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickupLocation != null) {
      data['pickupLocation'] = this.pickupLocation!.toJson();
    }
    data['_id'] = this.sId;
    if (this.passenger != null) {
      data['passenger'] = this.passenger!.toJson();
    }
    data['driver'] = this.driver;
    if (this.destinationLocation != null) {
      data['destinationLocation'] = this.destinationLocation!.toJson();
    }
    data['status'] = this.status;
    data['fare'] = this.fare;
    data['date'] = this.date;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['password'] = this.password;
    data['image'] = this.image;
    data['role'] = this.role;
    data['available'] = this.available;
    data['deviceToken'] = this.deviceToken;
    data['__v'] = this.iV;
    return data;
  }
}