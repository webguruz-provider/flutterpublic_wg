class CancelReasonModel {
  int? id;
  int? cancelReasonId;
  String? title;
  int? languageId;

  CancelReasonModel(
      {this.id, this.cancelReasonId, this.title, this.languageId});

  CancelReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cancelReasonId = json['cancel_reason_id'];
    title = json['title'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cancel_reason_id'] = this.cancelReasonId;
    data['title'] = this.title;
    data['language_id'] = this.languageId;
    return data;
  }
}
