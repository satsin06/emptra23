// To parse this JSON data, do
//
//     final getVehicleModel = getVehicleModelFromJson(jsonString);

import 'dart:convert';

GetVehicleModel getVehicleModelFromJson(String str) => GetVehicleModel.fromJson(json.decode(str));

String getVehicleModelToJson(GetVehicleModel data) => json.encode(data.toJson());

class GetVehicleModel {
  GetVehicleModel({
    this.code,
    this.result,
  });

  int code;
  List<Result> result;

  factory GetVehicleModel.fromJson(Map<String, dynamic> json) => GetVehicleModel(
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
    this.vehicleCategory,
    this.selectBrand,
    this.selectModel,
    this.vehicleType,
    this.registrationYear,
    this.transmissionType,
    this.variant,
    this.carRegistrationState,
    this.selectCarSRtoCode,
    this.rcNo,
    this.chassis,
    this.status,
    this.createdAt,
    this.createdBy,
    this.comment,
    this.docUrl,
    this.updatedAt,
    this.uploadedStatus,
  });

  String id;
  int userId;
  String vehicleCategory;
  String selectBrand;
  String selectModel;
  String vehicleType;
  String registrationYear;
  String transmissionType;
  String variant;
  String carRegistrationState;
  String selectCarSRtoCode;
  String rcNo;
  String chassis;
  String status;
  int createdAt;
  dynamic createdBy;
  dynamic comment;
  String docUrl;
  int updatedAt;
  String uploadedStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    vehicleCategory: json["vehicleCategory"],
    selectBrand: json["selectBrand"],
    selectModel: json["selectModel"],
    vehicleType: json["vehicleType"],
    registrationYear: json["registrationYear"],
    transmissionType: json["transmissionType"],
    variant: json["variant"],
    carRegistrationState: json["carRegistrationState"],
    selectCarSRtoCode: json["selectCarSRtoCode"],
    rcNo: json["rcNo"],
    chassis: json["chassis"],
    status: json["status"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    comment: json["comment"],
    docUrl: json["docUrl"] == null ? null : json["docUrl"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    uploadedStatus: json["uploadedStatus"] == null ? null : json["uploadedStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "vehicleCategory": vehicleCategory,
    "selectBrand": selectBrand,
    "selectModel": selectModel,
    "vehicleType": vehicleType,
    "registrationYear": registrationYear,
    "transmissionType": transmissionType,
    "variant": variant,
    "carRegistrationState": carRegistrationState,
    "selectCarSRtoCode": selectCarSRtoCode,
    "rcNo": rcNo,
    "chassis": chassis,
    "status": status,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "comment": comment,
    "docUrl": docUrl == null ? null : docUrl,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "uploadedStatus": uploadedStatus == null ? null : uploadedStatus,
  };
}
