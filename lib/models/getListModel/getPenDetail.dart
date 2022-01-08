class GetPenCardDetail {
  int code;
  Result result;

  GetPenCardDetail({this.code, this.result});

  GetPenCardDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String sId;
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

  Result(
      {this.sId,
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
        this.createdBy});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    userName = json['userName'];
    dob = json['dob'];
    gender = json['gender'];
    docType = json['docType'];
    docUrl = json['docUrl'];
    uploadedStatus = json['uploadedStatus'];
    status = json['status'];
    requestBy = json['requestBy'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['userName'] = this.userName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['docType'] = this.docType;
    data['docUrl'] = this.docUrl;
    data['uploadedStatus'] = this.uploadedStatus;
    data['status'] = this.status;
    data['requestBy'] = this.requestBy;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
