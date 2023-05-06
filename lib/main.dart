import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color(0xff171717),
        appBar:AppBar(
          backgroundColor: Color(0xffA71E27),
          title:  Text("24 Express"),
          centerTitle: false,
          leading: Icon(Icons.menu,size: 32,),
          actions: [
            Icon(Icons.search),
            SizedBox(width: 16,),
            Icon(Icons.shopping_cart,),
            SizedBox(width: 16,),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text("Welcome",
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 32,
                 decoration: TextDecoration.underline,
               ),
             ),
             SizedBox(height: 32,),
             TextField(
               decoration: InputDecoration(
                 labelText: "user name",
                 hintText: "please enter your user name",
                 labelStyle: TextStyle(
                   fontSize: 22,
                   color: Colors.white
                 ),

                 enabledBorder: OutlineInputBorder(),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(22)
                 ),
               ),
             ),
             SizedBox(height: 32,),
             TextField(
               decoration: InputDecoration(
                   labelText: "password",
                 enabledBorder: OutlineInputBorder(),
                 focusedBorder: OutlineInputBorder(),
               ),
             ),
           ],
          ),
        ),
      ),
    );
  }
}

