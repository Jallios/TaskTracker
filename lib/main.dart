import 'package:flutter/material.dart';
import 'package:task_tracker_flutter/di/service.dart';
import 'package:task_tracker_flutter/features/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const App());
}
