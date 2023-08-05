import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../services/firebase_authentication_srevice.dart';
import 'otp_screen.dart';
class SignUpScreen extends StatefulWidget{

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: (){
             Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 40,
            ),
          )
      ),
      body:ListView(
          padding: EdgeInsets.symmetric(horizontal: 16,),
          children:[
            SizedBox(height: 24,),
            Text("Sign\nUp",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 36,),
            errorMessage==null?
            SizedBox():
            Text(errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: "Name",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: "phone",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: "Password",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: "Confirm Password",
              ),
            ),
            SizedBox(height:32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ?
                CircularProgressIndicator()
                    :
                InkWell(
                  onTap: ()async{
                    isLoading =true;
                    setState(() {});
                    //call register api
                    FirebaseAuthenticationService.
                    signUp(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ).then(
                            (credential){
                              print("the  returned user data"
                                  " ${credential.user.toString()}");
                              print("the  returned user credential"
                                  " ${credential.credential.toString()}");
                              print("the  returned user credential"
                                  " ${credential.additionalUserInfo.toString()}");
                        },
                        onError: (err){
                              if(err  is FirebaseAuthException){
                                errorMessage  =err.code;
                              }else{
                                errorMessage  =err.toString();
                              }

                          setState(() {

                          });
                          print("error ${err.toString()}");
                        },
                    );

                    isLoading =false;
                    setState(() {});
                    // navigate to otp screen
                  },
                  child: Container(
                    height: 44,
                    width: 101,
                    decoration: BoxDecoration(
                      color:Color(0xffA71E27),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffA71E27),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                        )
                      ],
                    ),
                    child: Center(
                      child: Text('SIGN UP',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white ,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ]
      ),
    );
  }
}