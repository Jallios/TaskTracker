class ServerExeption implements Exception {}

class UserExeption implements Exception {
  final String message;

  UserExeption({required this.message});
}
