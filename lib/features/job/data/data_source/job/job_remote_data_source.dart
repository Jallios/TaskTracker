import 'package:dio/dio.dart';

abstract interface class JobRemote {}

class JobRemoteImpl implements JobRemote {
  final Dio dio;

  JobRemoteImpl({required this.dio});
}
