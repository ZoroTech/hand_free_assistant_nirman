import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirmaan Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        scaffoldBackgroundColor: Colors.grey.shade100,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/attendance': (_) => const AttendanceScreen(),
        '/tasks': (_) => const TasksScreen(),
        '/dpr': (_) => const DPRScreen(),
      },
    );
  }
}

// ----------------------------------------
// SCREENS
// ----------------------------------------

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📍 Attendance"),
        backgroundColor: Colors.yellow.shade600,
      ),
      body: const Center(child: Text("Attendance Screen")),
    );
  }
}

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📝 Tasks"),
        backgroundColor: Colors.yellow.shade600,
      ),
      body: const Center(child: Text("Tasks Screen")),
    );
  }
}

class DPRScreen extends StatelessWidget {
  const DPRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📸 DPR"),
        backgroundColor: Colors.yellow.shade600,
      ),
      body: const Center(child: Text("DPR Screen")),
    );
  }
}
