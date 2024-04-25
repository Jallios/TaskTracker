import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ProjectLocal {}

class ProjectLocalImpl implements ProjectLocal {
  final SharedPreferences sharedPreferences;

  ProjectLocalImpl(this.sharedPreferences);
}
