import 'package:flutter/foundation.dart';

abstract final class ApiEndpoints {
  static const String baseUrl = kDebugMode
      ? "http://192.168.3.14:5002/api/"
      : kProfileMode
          ? ""
          : "";
  static const String signIn = "Auth/signIn";
  static const String refresh = "Auth/refresh";
  static const String signUp = "Auth/signUp";
  static const String emailSendCode = "Auth/EmailSendCode";
  static const String passwordReset = "Auth/PasswordReset";
  static const String projectUserRoles = "ProjectUserRoles";
  static const String projects = "Projects";
}
