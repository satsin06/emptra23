class GetCourseHistoryModel {
  int code;
  List<Result> result;
  String userId;

  GetCourseHistoryModel({this.code, this.result, this.userId});

  GetCourseHistoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class Result {
  String sId;
  int userId;
  String name;
  String institution;
  String from;
  String to;
  String percentage;
  String description;
  String status;
  int etScore;
  int courseId;
  String createdAt;
  Null comment;
  String docUrl;
  int updatedAt;
  String uploadedStatus;

  Result(
      {this.sId,
        this.userId,
        this.name,
        this.institution,
        this.from,
        this.to,
        this.percentage,
        this.description,
        this.status,
        this.etScore,
        this.courseId,
        this.createdAt,
        this.comment,
        this.docUrl,
        this.updatedAt,
        this.uploadedStatus});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    institution = json['institution'];
    from = json['from'];
    to = json['to'];
    percentage = json['percentage'];
    description = json['description'];
    status = json['status'];
    etScore = json['etScore'];
    courseId = json['courseId'];
    createdAt = json['createdAt'];
    comment = json['comment'];
    docUrl = json['docUrl'];
    updatedAt = json['updatedAt'];
    uploadedStatus = json['uploadedStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['institution'] = this.institution;
    data['from'] = this.from;
    data['to'] = this.to;
    data['percentage'] = this.percentage;
    data['description'] = this.description;
    data['status'] = this.status;
    data['etScore'] = this.etScore;
    data['courseId'] = this.courseId;
    data['createdAt'] = this.createdAt;
    data['comment'] = this.comment;
    data['docUrl'] = this.docUrl;
    data['updatedAt'] = this.updatedAt;
    data['uploadedStatus'] = this.uploadedStatus;
    return data;
  }
}
