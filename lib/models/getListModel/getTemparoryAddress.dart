// To parse this JSON data, do
//
//     final getTemporaryAddress = getTemporaryAddressFromJson(jsonString);

import 'dart:convert';

GetTemporaryAddress getTemporaryAddressFromJson(String str) => GetTemporaryAddress.fromJson(json.decode(str));

String getTemporaryAddressToJson(GetTemporaryAddress data) => json.encode(data.toJson());

class GetTemporaryAddress {
  GetTemporaryAddress({
    this.code,
    this.result,
  });

  int code;
  List<Result> result;

  factory GetTemporaryAddress.fromJson(Map<String, dynamic> json) => GetTemporaryAddress(
    code: json["code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.organizationId,
    this.house,
    this.area,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.sameAsPermanent,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int userId;
  String firstName;
  String lastName;
  String organizationId;
  String house;
  String area;
  String landmark;
  String city;
  String state;
  String country;
  bool sameAsPermanent;
  String status;
  int createdAt;
  dynamic createdBy;
  int updatedAt;
  dynamic updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    organizationId: json["organizationId"],
    house: json["house"],
    area: json["area"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    sameAsPermanent: json["sameAsPermanent"],
    status: json["status"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "organizationId": organizationId,
    "house": house,
    "area": area,
    "landmark": landmark,
    "city": city,
    "state": state,
    "country": country,
    "sameAsPermanent": sameAsPermanent,
    "status": status,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}
