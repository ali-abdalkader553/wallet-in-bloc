import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_task/src/app.dart';
import 'package:wallet_task/src/utils/constants.dart';
import 'package:wallet_task/src/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  setUpGetIt();
  runApp(const App());
}
