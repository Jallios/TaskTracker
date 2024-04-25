class UserModel {
  int? idUser;
  String? surname;
  String? name;
  String? patronymic;
  String? email;
  bool? isConfrim;
  String? photo;
  String? login;
  String? password;
  String? salt;

  UserModel(
      {this.idUser,
      this.surname,
      this.name,
      this.patronymic,
      this.email,
      this.isConfrim,
      this.photo,
      this.login,
      this.password,
      this.salt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        idUser: json['id'],
        surname: json['surname'],
        name: json['name'],
        patronymic: json['patronymic'],
        email: json['email'],
        isConfrim: json['isConfrim'],
        photo: json['photo'],
        login: json['login'],
        password: json['password'],
        salt: json['salt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'surname': surname,
      'name': name,
      'patronymic': patronymic,
      'email': email,
      'isConfrim': isConfrim,
      'photo': photo,
      'login': login,
      'password': password,
      'salt': salt
    };
  }
}
