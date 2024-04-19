import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/firebase_options.dart';
import 'package:to_do_list/widget/view/taskListView.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that the Flutter app initializes the Firebase app

  await Firebase.initializeApp(
    // Initialize the Firebase app
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: CardTheme(color: Color.fromARGB(255, 253, 253, 253)),
        checkboxTheme:
            CheckboxThemeData(shape: CircleBorder(eccentricity: 0.1)),
        drawerTheme: DrawerThemeData(
            backgroundColor: Color.fromARGB(255, 253, 253, 253)),
        listTileTheme: ListTileThemeData(
          tileColor: const Color.fromARGB(255, 255, 248, 240),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 253, 233, 209),
            iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 136, 0))),
        colorScheme: ColorScheme.fromSeed(
            background: const Color.fromARGB(255, 255, 248, 240),
            seedColor: const Color.fromARGB(255, 255, 248, 240)),
        useMaterial3: true,
      ),
      home: TaskListView(),
    );
  }
}
