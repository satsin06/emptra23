// To parse this JSON data, do
//
//     final getAllHrDetail = getAllHrDetailFromJson(jsonString);

import 'dart:convert';

GetAllHrDetail getAllHrDetailFromJson(String str) => GetAllHrDetail.fromJson(json.decode(str));

String getAllHrDetailToJson(GetAllHrDetail data) => json.encode(data.toJson());

class GetAllHrDetail {
  GetAllHrDetail({
    this.code,
    this.message,
    this.result,
  });

  int code;
  String message;
  List<Result> result;

  factory GetAllHrDetail.fromJson(Map<String, dynamic> json) => GetAllHrDetail(
    code: json["code"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.organizationId,
    this.organizationName,
    this.hrName,
    this.hrEmail,
    this.hrNumber,
    this.userFirstName,
    this.userLastName,
    this.uploadedStatus,
    this.status,
    this.requestBy,
    this.createdAt,
    this.createdBy,
    this.clientSatisfaction,
    this.dedicationHandwork,
    this.learningGrowth,
    this.punctuality,
    this.review,
    this.teamWork,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int userId;
  String organizationId;
  String organizationName;
  String hrName;
  String hrEmail;
  int hrNumber;
  String userFirstName;
  String userLastName;
  String uploadedStatus;
  String status;
  String requestBy;
  int createdAt;
  String createdBy;
  int clientSatisfaction;
  int dedicationHandwork;
  int learningGrowth;
  int punctuality;
  String review;
  int teamWork;
  int updatedAt;
  String updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    organizationId: json["organizationId"],
    organizationName: json["organizationName"],
    hrName: json["hrName"],
    hrEmail: json["hrEmail"],
    hrNumber: json["hrNumber"],
    userFirstName: json["userFirstName"],
    userLastName: json["userLastName"],
    uploadedStatus: json["uploadedStatus"],
    status: json["status"],
    requestBy: json["requestBy"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    clientSatisfaction: json["clientSatisfaction"],
    dedicationHandwork: json["dedicationHandwork"],
    learningGrowth: json["learningGrowth"],
    punctuality: json["punctuality"],
    review: json["review"],
    teamWork: json["teamWork"],
    updatedAt: json["updatedAt"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "organizationId": organizationId,
    "organizationName": organizationName,
    "hrName": hrName,
    "hrEmail": hrEmail,
    "hrNumber": hrNumber,
    "userFirstName": userFirstName,
    "userLastName": userLastName,
    "uploadedStatus": uploadedStatus,
    "status": status,
    "requestBy": requestBy,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "clientSatisfaction": clientSatisfaction,
    "dedicationHandwork": dedicationHandwork,
    "learningGrowth": learningGrowth,
    "punctuality": punctuality,
    "review": review,
    "teamWork": teamWork,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}
