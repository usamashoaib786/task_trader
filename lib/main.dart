import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_trader/Providers/homeprovider.dart';
import 'package:task_trader/Views/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: Splash()));
  }
}
