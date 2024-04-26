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
        publish:
            json['publish'] != null ? DateTime.tryParse(json['publish']) : null,
        deadline: json['deadline'] != null
            ? DateTime.tryParse(json['deadline'])
            : null);
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
