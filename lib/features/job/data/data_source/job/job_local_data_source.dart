import 'package:shared_preferences/shared_preferences.dart';

abstract interface class JobLocal {}

class JobLocalImpl implements JobLocal {
  final SharedPreferences sharedPreferences;

  JobLocalImpl(this.sharedPreferences);
}
