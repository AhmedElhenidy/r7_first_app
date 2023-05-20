import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget{

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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: "Name",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                hintText: "phone",
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: "Password",
              ),
            ),
            SizedBox(height:32,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    print("sign up");
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