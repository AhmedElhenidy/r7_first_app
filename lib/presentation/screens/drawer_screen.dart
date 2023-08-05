import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r7_first_app/presentation/screens/sign_in_screen.dart';

import '../../models/user_model.dart';

class DrawerScreen extends StatefulWidget {
  final UserModel userModel;
  const DrawerScreen({required this.userModel,super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final picker = ImagePicker();
  void pickImage()async{
    //for camera
   // final xFile = await picker.pickImage(source: ImageSource.camera);
    //for gallery
    final xFile = await picker.pickImage(source: ImageSource.gallery);
   if(xFile!=null){
     print("the selectedFile is ${xFile.name}");
    final uploadTask =  FirebaseStorage.instance.ref("userImages").putFile(
       File(xFile.path),
     );
     uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async{
       switch (taskSnapshot.state) {
         case TaskState.running:
           final progress =
               100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
           print("Upload is $progress% complete.");
           break;
         case TaskState.paused:
           print("Upload is paused.");
           break;
         case TaskState.canceled:
           print("Upload was canceled");
           break;
         case TaskState.error:
           print("Upload Error");
           break;
         case TaskState.success:
           print("success ${await taskSnapshot.ref.getDownloadURL()}");
           //update fire store  image field
         FirebaseFirestore.instance.collection("users")
         .doc(FirebaseAuth.instance.currentUser?.uid)
         .update({
           "image":await taskSnapshot.ref.getDownloadURL(),
         }).then((val)async{
           widget.userModel.image=await taskSnapshot.ref.getDownloadURL();
           setState(() {});
         });
           break;
       }
     });
   }else{
     print("no selected File");
   }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Color(0xFF171717),
      child: Column(
        children: [
          Container(
            height: 240,
            color: Color(0xffA71E27),
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: InkWell(
                    onTap: (){
                      pickImage();
                    },
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        widget.userModel.image??""
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  children: [
                    Text(widget.userModel.name??"",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        FirebaseFirestore.instance.
                        collection("users").
                        doc(FirebaseAuth.instance.currentUser?.uid)
                            .update({
                          "phone":"01010301140"
                        }).then((value) => setState((){}));
                      },
                      child: Icon(
                        Icons.edit,color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Text(widget.userModel.phone??"",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(widget.userModel.mail??"",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 16,),
                    Text("Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 16,),
                    Text("Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 16,),
                    Text("Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24,),
                ListTile(
                  onTap: ()async{
                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    FirebaseAuth.instance.signOut().then((value){
                      FirebaseFirestore.instance.collection("users").doc(uid).delete().
                      then((value){
                        Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(
                          builder: (builder)=>SignInScreen(),
                        ),
                              (route) => false,
                        );
                      },
                      );
                    });

                  },
                  leading:Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: Text("Sign out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
