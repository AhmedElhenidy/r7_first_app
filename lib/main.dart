import 'package:flutter/material.dart';
import 'package:r7_first_app/presentation/screens/sign_in_screen.dart';

void main(){
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
      home: SignInScreen(),
    );
  }
}

