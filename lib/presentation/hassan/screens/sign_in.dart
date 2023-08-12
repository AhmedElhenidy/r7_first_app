import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/auth_cubit/auth_cubit.dart';
import 'package:r7_first_app/presentation/hassan/screens/sign_up.dart';
import '../../../services/firebase_authentication_srevice.dart';
import 'home_screen.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();

}
class _SignInState extends State<SignIn>{
  bool isobsecured = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print("listener state is $state");
         // navigate Auth Success state
          if(state is AuthSuccess){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(
                    builder: (builder)=>HomeScreen()
                ),
                (route)=>false,
            );
          }
        },
        child: SingleChildScrollView(
              child: Container(
              margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                children: [
                  // BlocConsumer(
                  //   builder: (context,state){},
                  //   listener: (context,state){},
                  // ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 100),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<AuthCubit,AuthState>(
                    builder: (context,state){
                      return state is AuthErrorState
                      ?
                      Text("${state.msg}",
                        style: TextStyle(fontSize: 20,color: Colors.red,),
                      )
                      :
                      SizedBox();
                    },
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                        enabled: true,
                        labelText: "Email,User",
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                        floatingLabelStyle: const TextStyle(color: Colors.red),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(width: 2, color: Colors.red)),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: isobsecured,
                    decoration: InputDecoration(
                      suffixIcon:  IconButton(
                        icon: isobsecured?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isobsecured =!isobsecured;
                          });
                        },
                      ),
                      hintText: "Enter your password",
                      labelText: "password",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.red),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(50)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(width: 2, color: Colors.red)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return ChangePasswordConfirmstion();
                          // },),);
                          },
                          child:const Text(
                        "Forget Password! ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )), ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<AuthCubit,AuthState>(
                    builder: (context,state){
                      print("current state is ${state}");
                       return state is AuthLoadingState
                          ?
                      CircularProgressIndicator()
                          :
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 182, 48, 18),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 124, 34, 28),
                                offset: Offset(0, 5),
                                blurRadius: 15,
                              )
                            ]),
                        child: InkWell(
                            onTap: (){
                              BlocProvider.of<AuthCubit>(context)
                                  .singIn(_emailController.text,
                                  _passwordController.text, context,
                              );

                            },
                            child: const Text(
                              "SIGN IN",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      );
                    },
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don\'t have an account?  ",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder:(context){
                                return const SignUp();
                              },),
                            );
                          },
                          child:  const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 183, 49, 40), fontSize: 15),
                          )

                      )
                    ],
                  )
                ],
              ),
              ),
            ),
      ),
    );
  }
}
