import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash_screen.dart';

import 'features/auth/view/signup_view.dart';
void main ()async    {
  WidgetsFlutterBinding.ensureInitialized();
   await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ]
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.light(
          primary: const Color(0xff103e34),
          secondary: const Color(0xFF2A5F4F),
          tertiary: const Color(0xFF4A9B8A),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
          error: Colors.red.shade400,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black87,
          onBackground: Colors.black87,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF4A9B8A),
          secondary: const Color(0xFF6BC4B0),
          tertiary: const Color(0xFF7DD3C0),
          surface: const Color(0xFF1E1E1E),
          background: const Color(0xFF121212),
          error: Colors.red.shade300,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'Hungry App',
      home: SplashView(),
    );
  }
}


