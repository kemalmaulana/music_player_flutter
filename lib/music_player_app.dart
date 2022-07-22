import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/bindings/global_bindings.dart';
import 'package:music_player/const/app_colors.dart';
import 'package:music_player/route/routes.dart';
import 'package:music_player/view/home_screen.dart';

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Music Player',
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        visualDensity: VisualDensity.comfortable,
        textTheme: GoogleFonts.robotoTextTheme(Theme
            .of(context)
            .textTheme),
        backgroundColor: backgroundColor,
        // buttonColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: backgroundColor),
        fontFamily: 'Poppins',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
          color: primaryColor,
          centerTitle: true,
          toolbarTextStyle: const TextTheme(
            headline1: TextStyle(
              fontSize: 10,
            ),
            headline2: TextStyle(fontSize: 12),
            headline3: TextStyle(
              fontSize: 14,
            ),
            headline4: TextStyle(
              fontSize: 16,
            ),
            headline5: TextStyle(
              fontSize: 18,
            ),
            headline6: TextStyle(
              fontSize: 20,
            ),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            headline1: TextStyle(
              fontSize: 10,
            ),
            headline2: TextStyle(fontSize: 12),
            headline3: TextStyle(
              fontSize: 14,
            ),
            headline4: TextStyle(
              fontSize: 16,
            ),
            headline5: TextStyle(
              fontSize: 18,
            ),
            headline6: TextStyle(
              fontSize: 20,
            ),
          ).headline6,
        ),
      ),
      initialRoute: HomeScreen.routeName,
      getPages: pages,
    );
  }

}
