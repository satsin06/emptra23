// To parse this JSON data, do
//
//     final getEmailVerify = getEmailVerifyFromJson(jsonString);

import 'dart:convert';

GetEmailVerify getEmailVerifyFromJson(String str) => GetEmailVerify.fromJson(json.decode(str));

String getEmailVerifyToJson(GetEmailVerify data) => json.encode(data.toJson());

class GetEmailVerify {
  GetEmailVerify({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetEmailVerify.fromJson(Map<String, dynamic> json) => GetEmailVerify(
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
    this.firstName,
    this.email,
    this.status,
    this.verificationToken,
    this.createdAt,
    this.createdBy,
  });

  String id;
  int userId;
  String firstName;
  String email;
  String status;
  String verificationToken;
  int createdAt;
  dynamic createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    firstName: json["firstName"],
    email: json["email"],
    status: json["status"],
    verificationToken: json["verificationToken"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "firstName": firstName,
    "email": email,
    "status": status,
    "verificationToken": verificationToken,
    "createdAt": createdAt,
    "createdBy": createdBy,
  };
}
