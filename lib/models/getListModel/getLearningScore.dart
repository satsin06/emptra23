// To parse this JSON data, do
//
//     final getLearningScore = getLearningScoreFromJson(jsonString);

import 'dart:convert';

GetLearningScore getLearningScoreFromJson(String str) => GetLearningScore.fromJson(json.decode(str));

String getLearningScoreToJson(GetLearningScore data) => json.encode(data.toJson());

class GetLearningScore {
  GetLearningScore({
    this.code,
    this.userId,
    this.learningScore,
  });

  int code;
  String userId;
  int learningScore;

  factory GetLearningScore.fromJson(Map<String, dynamic> json) => GetLearningScore(
    code: json["code"],
    userId: json["userId"],
    learningScore: json["learningScore"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "userId": userId,
    "learningScore": learningScore,
  };
}
