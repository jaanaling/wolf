import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/core/dependency_injection.dart';
import 'src/feature/app/presentation/app_root.dart';

late bool isNotes;
late bool isTrip;
late bool isResourse;
late bool isHome;
late bool isCalculator;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencyInjection();

  final prefs = await SharedPreferences.getInstance();
  isNotes = prefs.getBool('isNotes') ?? false;
  isTrip = prefs.getBool('isTrip') ?? false;
  isResourse = prefs.getBool('isResourse') ?? false;
  isCalculator = prefs.getBool('isCalculator') ?? false;
  isHome = prefs.getBool('isHome') ?? false;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const AppRoot());
}
