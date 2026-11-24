import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialTheme? _materialTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _materialTheme = MaterialTheme(Theme.of(context).textTheme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = _materialTheme ?? MaterialTheme(Theme.of(context).textTheme);
    return MaterialApp(
      title: 'MSD - MySpaDeal',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
