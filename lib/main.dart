import 'package:expense_tracker_provider/Provider/task_provider.dart';
import 'package:expense_tracker_provider/Views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => TaskProvider(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            titleTextStyle: TextStyle(fontSize: 24, color: Colors.white),
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    ),
    );
  }
}
