// To parse this JSON data, do
//
//     final getRtpcrModel = getRtpcrModelFromJson(jsonString);

import 'dart:convert';

GetRtpcrModel getRtpcrModelFromJson(String str) => GetRtpcrModel.fromJson(json.decode(str));

String getRtpcrModelToJson(GetRtpcrModel data) => json.encode(data.toJson());

class GetRtpcrModel {
  GetRtpcrModel({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetRtpcrModel.fromJson(Map<String, dynamic> json) => GetRtpcrModel(
    code: json["code"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.name,
    this.date,
    this.time,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.service,
  });

  String id;
  int userId;
  String name;
  String date;
  String time;
  String status;
  int createdAt;
  int updatedAt;
  String address;
  String service;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    date: json["date"],
    time: json["time"],
    status: json["status"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    address: json["address"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "date": date,
    "time": time,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "address": address,
    "service": service,
  };
}
