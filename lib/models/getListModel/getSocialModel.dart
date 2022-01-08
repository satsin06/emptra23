// To parse this JSON data, do
//
//     final getSocialHistoryModel = getSocialHistoryModelFromJson(jsonString);

import 'dart:convert';

GetSocialHistoryModel getSocialHistoryModelFromJson(String str) => GetSocialHistoryModel.fromJson(json.decode(str));

String getSocialHistoryModelToJson(GetSocialHistoryModel data) => json.encode(data.toJson());

class GetSocialHistoryModel {
  GetSocialHistoryModel({
    this.code,
    this.result,
    this.userId,
  });

  int code;
  List<Result> result;
  String userId;

  factory GetSocialHistoryModel.fromJson(Map<String, dynamic> json) => GetSocialHistoryModel(
    code: json["code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "userId": userId,
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.partnerName,
    this.helpType,
    this.date,
    this.details,
    this.status,
    this.helpStatsId,
    this.createdAt,
    this.comment,
    this.docUrl,
    this.updatedAt,
    this.uploadedStatus,
  });

  String id;
  int userId;
  String partnerName;
  String helpType;
  String date;
  String details;
  String status;
  int helpStatsId;
  DateTime createdAt;
  dynamic comment;
  String docUrl;
  int updatedAt;
  String uploadedStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    partnerName: json["partnerName"],
    helpType: json["helpType"],
    date: json["date"],
    details: json["details"],
    status: json["status"],
    helpStatsId: json["helpStatsId"],
    createdAt: DateTime.parse(json["createdAt"]),
    comment: json["comment"],
    docUrl: json["docUrl"] == null ? null : json["docUrl"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    uploadedStatus: json["uploadedStatus"] == null ? null : json["uploadedStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "partnerName": partnerName,
    "helpType": helpType,
    "date": date,
    "details": details,
    "status": status,
    "helpStatsId": helpStatsId,
    "createdAt": createdAt.toIso8601String(),
    "comment": comment,
    "docUrl": docUrl == null ? null : docUrl,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "uploadedStatus": uploadedStatus == null ? null : uploadedStatus,
  };
}
