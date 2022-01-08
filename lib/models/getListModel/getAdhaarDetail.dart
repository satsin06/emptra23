// To parse this JSON data, do
//
//     final getAdhaarDetail = getAdhaarDetailFromJson(jsonString);

import 'dart:convert';

GetAdhaarDetail getAdhaarDetailFromJson(String str) => GetAdhaarDetail.fromJson(json.decode(str));

String getAdhaarDetailToJson(GetAdhaarDetail data) => json.encode(data.toJson());

class GetAdhaarDetail {
  GetAdhaarDetail({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetAdhaarDetail.fromJson(Map<String, dynamic> json) => GetAdhaarDetail(
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
    this.organizationId,
    this.organizationName,
    this.userName,
    this.dob,
    this.gender,
    this.docType,
    this.docUrl,
    this.uploadedStatus,
    this.status,
    this.requestBy,
    this.createdAt,
    this.createdBy,
  });

  String id;
  int userId;
  int organizationId;
  String organizationName;
  String userName;
  String dob;
  String gender;
  String docType;
  String docUrl;
  String uploadedStatus;
  String status;
  String requestBy;
  int createdAt;
  String createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    organizationId: json["organizationId"],
    organizationName: json["organizationName"],
    userName: json["userName"],
    dob: json["dob"],
    gender: json["gender"],
    docType: json["docType"],
    docUrl: json["docUrl"],
    uploadedStatus: json["uploadedStatus"],
    status: json["status"],
    requestBy: json["requestBy"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "organizationId": organizationId,
    "organizationName": organizationName,
    "userName": userName,
    "dob": dob,
    "gender": gender,
    "docType": docType,
    "docUrl": docUrl,
    "uploadedStatus": uploadedStatus,
    "status": status,
    "requestBy": requestBy,
    "createdAt": createdAt,
    "createdBy": createdBy,
  };
}
