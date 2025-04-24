import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_workout_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/stopwatch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCWaQD9SIGFe5FnMFbD5PZKEPE3Wjl_380",
      authDomain: "flexify-f34bc.firebaseapp.com",
      projectId: "flexify-f34bc",
      storageBucket: "flexify-f34bc.firebasestorage.app",
      messagingSenderId: "830292911801",
      appId: "1:830292911801:web:98afc602176685249cdd68",
    ),
  );
  runApp(const FlexifyApp());
}

class FlexifyApp extends StatelessWidget {
  const FlexifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Global font family
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/addWorkout': (context) => const AddWorkoutScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/stopwatch': (context) => const StopwatchScreen(),
      },
    );
  }
}
