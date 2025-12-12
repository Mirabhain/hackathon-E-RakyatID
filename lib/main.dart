import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'viewmodels/user_profile_view_model.dart';
import 'view/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => HomeNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()), 
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        fontFamily: GoogleFonts.quicksand().fontFamily,
      ),
      home: const HomeScreen(),
    );
  }
}
