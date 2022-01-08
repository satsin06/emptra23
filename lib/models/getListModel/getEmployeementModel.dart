class GetEmployeementHistoryModel {
  int code;
  List<Result> result;
  String userId;

  GetEmployeementHistoryModel({this.code, this.result, this.userId});

  GetEmployeementHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String employerId;
  String employerName;
  String website;
  String designation;
  String from;
  bool isWorking;
  String to;
  String about;
  String status;
  Null comment;
  String docUrl;
  int updatedAt;
  String uploadedStatus;
  int etScore;
  int updated;

  Result(
      {this.sId,
        this.userId,
        this.employerId,
        this.employerName,
        this.website,
        this.designation,
        this.from,
        this.isWorking,
        this.to,
        this.about,
        this.status,
        this.comment,
        this.docUrl,
        this.updatedAt,
        this.uploadedStatus,
        this.etScore,
        this.updated});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    employerId = json['employerId'];
    employerName = json['employerName'];
    website = json['website'];
    designation = json['designation'];
    from = json['from'];
    isWorking = json['isWorking'];
    to = json['to'];
    about = json['about'];
    status = json['status'];
    comment = json['comment'];
    docUrl = json['docUrl'];
    updatedAt = json['updatedAt'];
    uploadedStatus = json['uploadedStatus'];
    etScore = json['etScore'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['employerId'] = this.employerId;
    data['employerName'] = this.employerName;
    data['website'] = this.website;
    data['designation'] = this.designation;
    data['from'] = this.from;
    data['isWorking'] = this.isWorking;
    data['to'] = this.to;
    data['about'] = this.about;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['docUrl'] = this.docUrl;
    data['updatedAt'] = this.updatedAt;
    data['uploadedStatus'] = this.uploadedStatus;
    data['etScore'] = this.etScore;
    data['updated'] = this.updated;
    return data;
  }
}
