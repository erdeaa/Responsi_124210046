import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffFF7F00),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87)),
          colorScheme: const ColorScheme.light(
            background: Color(0xffF5E6D4),
            primary: Color(0xffffd299),
            secondary: Color(0xffFFFF8D),
          )),
      title: 'Meals App',
      home: const HomePage(),
    );
  }
}
