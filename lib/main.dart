import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/auth_cubit/auth_cubit.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/cart_cubit/cart_cubit.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/home_cubit/home_cubit.dart';
import 'package:r7_first_app/presentation/hassan/screens/home_screen.dart';
import 'package:r7_first_app/presentation/hassan/screens/sign_in.dart';
import 'package:r7_first_app/presentation/screens/home_screen.dart';
import 'package:r7_first_app/presentation/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (BuildContext context) => CartCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
      home: FirebaseAuth.instance.currentUser!=null
          ?
          HomeScreen()
          :
      SignIn(),
    );
  }
}

