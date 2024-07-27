import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mybook_library/screens/home_screen.dart';
import 'package:mybook_library/providers/book_provider.dart';
import 'package:mybook_library/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'MyBook Library',
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: HomeScreen(),
        );
      },
    );
  }
}
