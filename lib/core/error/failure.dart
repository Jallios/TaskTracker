sealed class Failure {}

class ServerFailure extends Failure {}

class UserFailure extends Failure {
  final String message;

  UserFailure({required this.message});
}
