import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:r7_first_app/presentation/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 32,right: 32,top: 122),
          child: Column(
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 64,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      labelText: "Email,User",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.red)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 64,
                child: TextField(
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: Colors.grey,
                    ),
                    floatingLabelStyle: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Forget Password!',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                      boxShadow: [
                    BoxShadow(
                      color:Color(0xffA71E27).withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                    borderRadius: BorderRadius.circular(22),
                      color: Color(0xffA71E27),
                  ),
                  child: Center(
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Navigate to the sign up screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return SignUpScreen();
                          },),
                      );
                    },
                    child: const Text(
                      'Sing up',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}