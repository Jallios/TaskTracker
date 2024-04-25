import 'package:task_tracker_flutter/core/emm/entity/user_entity.dart';
import 'package:task_tracker_flutter/core/emm/model/user_model.dart';

extension UserMapperModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        idUser: idUser,
        surname: surname,
        name: name,
        patronymic: patronymic,
        email: email,
        isConfrim: isConfrim,
        photo: photo,
        login: login,
        password: password,
        salt: salt);
  }
}

extension UserMapperEntity on UserEntity {
  UserModel toModel() {
    return UserModel(
        idUser: idUser,
        surname: surname,
        name: name,
        patronymic: patronymic,
        email: email,
        isConfrim: isConfrim,
        photo: photo,
        login: login,
        password: password,
        salt: salt);
  }
}
