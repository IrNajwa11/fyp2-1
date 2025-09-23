import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.isDarkMode
                ? ThemeData.dark().copyWith(
                    primaryColor: Color(0xFF0A8484),
                    scaffoldBackgroundColor: Colors.black,
                  )
                : ThemeData.light().copyWith(
                    primaryColor: Color(0xFF0A8484),
                    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                  ),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
