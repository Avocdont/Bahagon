import 'package:flutter/material.dart';
import 'database/database.dart';
import 'screens/login_screen.dart';

void main() async {
  // Ensure widgets are bound for async calls
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  // SEED THE ADMIN ACCOUNT
  await database.seedDefaultAdmin();

  runApp(EcommerceApp(database: database));
}

class EcommerceApp extends StatelessWidget {
  final AppDatabase database;

  EcommerceApp({required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: LoginScreen(database: database),
      debugShowCheckedModeBanner: false,
    );
  }
}
