class PriorityModel {
  int? idPriority;
  String? title;

  PriorityModel({this.idPriority, this.title});

  factory PriorityModel.fromJson(Map<String, dynamic> json) {
    return PriorityModel(idPriority: json['idPriority'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'idPriority': idPriority, 'title': title};
  }
}
