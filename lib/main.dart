import 'package:flutter/material.dart';
import 'package:movie_app/screens/movies_sreen.dart';
import 'package:movie_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//DarkThemeProvider themeProvider = new DarkThemeProvider();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void getCurrentAppTheme() async {
  //   themeData = await themeProvider.getTheme();
  //   setState(() {
  //     themeProvider.darkTheme(themeData);
  //   });
  //
  //   print('this my app : ${themeProvider.darkThemeData}');
  // }
  //
  // void getThemeData()async{
  //  final ahmed= await DarkThemeProvider().getTheme();
  //   print(ahmed);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DarkThemeProvider(),
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, widget) {
          return value.darkMode == null
              ? CircularProgressIndicator()
              : MaterialApp(
                  theme: value.darkMode
                      ? ThemeData.dark().copyWith(
                          accentColor: Colors.amber,
                          buttonColor: Colors.amber,
                          iconTheme: IconThemeData(color: Colors.black),
                        )
                      : ThemeData.light().copyWith(
                          scaffoldBackgroundColor: Color(0xFFF5F6FA),
                          primaryColor: Colors.amber[700],
                          accentColor: Colors.amber[800],
                          buttonColor: Colors.amber,
                          iconTheme: IconThemeData(color: Color(0xFFF5F6FA)),
                        ),
                  home: MoviesScreen(),
                );
        },
      ),
    );
  }
}
