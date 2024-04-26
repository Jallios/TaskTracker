class StatusModel {
  int? idStatus;
  String? title;

  StatusModel({this.idStatus, this.title});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(idStatus: json['idStatus'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'idStatus': idStatus, 'title': title};
  }
}
