import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r7_first_app/presentation/screens/home_screen.dart';
import 'package:r7_first_app/presentation/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  var token =  pref.getString('token');
  print("token is $token");
  isLoggedIn = token==null?false:true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // backgroundColor: Colors.yellow,
        ),
        // scaffoldBackgroundColor: Colors.pink,

      ),
      home: isLoggedIn
          ?
          HomeScreen()
          :
      SignInScreen(),
    );
  }
}

