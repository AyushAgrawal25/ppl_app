import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/Models/AppState.dart';
import 'package:ppl_app/UserInterface/Pages/Home/HomePage.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) {
      return AppState();
    },
    child: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addObserver(this);
    }
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColorScheme.bgColor));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PPL",
      color: AppColorScheme.themeColor,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          // Bottom Sheet Color
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: AppColorScheme.bgColor),

          // Default BG Color
          backgroundColor: AppColorScheme.bgColor,

          // Text Theme
          textTheme: TextTheme(
            bodyText1: GoogleFonts.nunito(color: AppColorScheme.textColor),
            bodyText2: GoogleFonts.nunito(color: AppColorScheme.textColor),
          ),

          // Dialog BG Color
          dialogBackgroundColor: AppColorScheme.bgColor,

          // Scaffold BG Color
          scaffoldBackgroundColor: AppColorScheme.bgColor,

          // Icon Theme Color
          iconTheme: IconThemeData(color: AppColorScheme.textColor),
          primaryColor: AppColorScheme.themeColor),
      darkTheme: ThemeData(
          // Bottom Sheet Color
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: AppColorScheme.bgColor),

          // Default BG Color
          backgroundColor: AppColorScheme.bgColor,

          // Text Theme
          textTheme: TextTheme(
            bodyText1: GoogleFonts.nunito(color: AppColorScheme.textColor),
            bodyText2: GoogleFonts.nunito(color: AppColorScheme.textColor),
          ),

          // Dialog BG Color
          dialogBackgroundColor: AppColorScheme.bgColor,

          // Scaffold BG Color
          scaffoldBackgroundColor: AppColorScheme.bgColor,

          // Icon Theme Color
          iconTheme: IconThemeData(color: AppColorScheme.textColor),
          primaryColor: AppColorScheme.themeColor),
      home: HomePage(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.removeObserver(this);
    }
  }
}
