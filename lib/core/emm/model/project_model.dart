class ProjectModel {
  int? idProject;
  String? title;
  DateTime? publish;
  DateTime? deadline;

  ProjectModel({this.idProject, this.title, this.publish, this.deadline});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        idProject: json['idProject'],
        title: json['title'],
        publish: DateTime.tryParse(json['publish']),
        deadline: DateTime.tryParse(json['deadline']));
  }

  Map<String, dynamic> toJson() {
    return {
      'idProject': idProject,
      'title': title,
      'publish': publish?.toIso8601String(),
      'deadline': deadline?.toIso8601String()
    };
  }
}
