class GetEducationHistoryModel {
  int code;
  List<Result> result;
  String userId;

  GetEducationHistoryModel({this.code, this.result, this.userId});

  GetEducationHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String instituteId;
  String instituteName;
  String specialization;
  String cgpa;
  String website;
  String from;
  String to;
  bool isWorking;
  String status;
  int historyId;
  String createdAt;
  int etScore;
  int updated;

  Result(
      {this.sId,
        this.userId,
        this.instituteId,
        this.instituteName,
        this.specialization,
        this.cgpa,
        this.website,
        this.from,
        this.to,
        this.isWorking,
        this.status,
        this.historyId,
        this.createdAt,
        this.etScore,
        this.updated});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    instituteId = json['instituteId'];
    instituteName = json['instituteName'];
    specialization = json['specialization'];
    cgpa = json['cgpa'];
    website = json['website'];
    from = json['from'];
    to = json['to'];
    isWorking = json['isWorking'];
    status = json['status'];
    historyId = json['historyId'];
    createdAt = json['createdAt'];
    etScore = json['etScore'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['instituteId'] = this.instituteId;
    data['instituteName'] = this.instituteName;
    data['specialization'] = this.specialization;
    data['cgpa'] = this.cgpa;
    data['website'] = this.website;
    data['from'] = this.from;
    data['to'] = this.to;
    data['isWorking'] = this.isWorking;
    data['status'] = this.status;
    data['historyId'] = this.historyId;
    data['createdAt'] = this.createdAt;
    data['etScore'] = this.etScore;
    data['updated'] = this.updated;
    return data;
  }
}
