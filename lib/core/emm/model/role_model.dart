class RoleModel {
  int? idRole;
  String? title;

  RoleModel({this.idRole, this.title});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(idRole: json['idRole'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'idRole': idRole, 'title': title};
  }
}
