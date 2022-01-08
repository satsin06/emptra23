// To parse this JSON data, do
//
//     final getHealthScore = getHealthScoreFromJson(jsonString);

import 'dart:convert';

GetHealthScore getHealthScoreFromJson(String str) => GetHealthScore.fromJson(json.decode(str));

String getHealthScoreToJson(GetHealthScore data) => json.encode(data.toJson());

class GetHealthScore {
  GetHealthScore({
    this.code,
    this.message,
    this.userId,
    this.healthScore,
  });

  int code;
  String message;
  String userId;
  int healthScore;

  factory GetHealthScore.fromJson(Map<String, dynamic> json) => GetHealthScore(
    code: json["code"],
    message: json["message"],
    userId: json["userId"],
    healthScore: json["healthScore"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "userId": userId,
    "healthScore": healthScore,
  };
}
