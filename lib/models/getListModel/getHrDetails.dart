class GetHrDetails {
  int code;
  String message;
  Result result;

  GetHrDetails({this.code, this.message, this.result});

  GetHrDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String sId;
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

  Result(
      {this.sId,
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
        this.updatedBy});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    hrName = json['hrName'];
    hrEmail = json['hrEmail'];
    hrNumber = json['hrNumber'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    uploadedStatus = json['uploadedStatus'];
    status = json['status'];
    requestBy = json['requestBy'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    clientSatisfaction = json['clientSatisfaction'];
    dedicationHandwork = json['dedicationHandwork'];
    learningGrowth = json['learningGrowth'];
    punctuality = json['punctuality'];
    review = json['review'];
    teamWork = json['teamWork'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['hrName'] = this.hrName;
    data['hrEmail'] = this.hrEmail;
    data['hrNumber'] = this.hrNumber;
    data['userFirstName'] = this.userFirstName;
    data['userLastName'] = this.userLastName;
    data['uploadedStatus'] = this.uploadedStatus;
    data['status'] = this.status;
    data['requestBy'] = this.requestBy;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['clientSatisfaction'] = this.clientSatisfaction;
    data['dedicationHandwork'] = this.dedicationHandwork;
    data['learningGrowth'] = this.learningGrowth;
    data['punctuality'] = this.punctuality;
    data['review'] = this.review;
    data['teamWork'] = this.teamWork;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}
