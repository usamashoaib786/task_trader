import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_trader/Providers/homeprovider.dart';
import 'package:task_trader/Views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
