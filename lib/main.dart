import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/job_application.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the generated adapter
  Hive.registerAdapter(JobApplicationAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Application Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo, // Set your primary color
          accentColor: Colors.teal,    // Set your accent color
        ),
        fontFamily: 'Roboto',        // Choose a modern font
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,    // Set your button primary color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}