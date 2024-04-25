class UserEntity {
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

  UserEntity(
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
}
