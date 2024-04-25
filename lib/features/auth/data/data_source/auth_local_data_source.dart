import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker_flutter/core/utils/key_shared_preferences.dart';

abstract interface class AuthLocal {
  String getToken();
  void setToken(String token);
  bool isUserSignIn();
}

class AuthLocalImpl implements AuthLocal {
  final SharedPreferences sharedPreferences;

  AuthLocalImpl(this.sharedPreferences);

  @override
  String getToken() =>
      sharedPreferences.getString(KeySharedPreferences.keyToken) ?? "";

  @override
  bool isUserSignIn() =>
      sharedPreferences.getString(KeySharedPreferences.keyToken) != null;

  @override
  Future<void> setToken(String token) async {
    await sharedPreferences.setString(KeySharedPreferences.keyToken, token);
  }
}
