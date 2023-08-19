import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/home_cubit/home_cubit.dart';
import 'package:r7_first_app/presentation/hassan/screens/category_products.dart';
import 'package:r7_first_app/presentation/hassan/screens/favourite_screen.dart';
import 'package:r7_first_app/presentation/hassan/screens/product_details_screen.dart';
import '../../../models/user_model.dart';
import '../widgets/appbar.dart';
import 'categories.dart';
import 'drawer_screen.dart';
class HomeScreen extends StatefulWidget{

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final userModel = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).
    get().then((value) {
      userModel.name  = value.data()?['name'];
      userModel.phone  = value.data()?['phone'];
      userModel.mail  = value.data()?['mail'];
      userModel.id  = value.data()?['id'];
      userModel.image  = value.data()?['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit= BlocProvider.of<HomeCubit>(context);
        return Scaffold(
          backgroundColor: const Color(0xff171717),
          appBar: CustomAppBarWidget(
            title: cubit.current==2?"Favourites":cubit.current==1?"Categories":"24 Express",
          ),
          drawerScrimColor: Colors.transparent.withOpacity(0.75),
          drawer: DrawerScreen(userModel: userModel,),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
            child: BottomNavigationBar(
                selectedItemColor: Colors.red,
                currentIndex: cubit.current,
                onTap: cubit.changeCurrentIndex,
                items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Categories",
                icon: Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: "Favourites",
                icon: Icon(Icons.favorite_border),
              ),
            ]),
          ),
          body:cubit.current==2?const FavScreen():cubit.current==1?const Categories(showAppBar: false,): ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection("categories").get(),
                builder: (context,snapShot){
                  print(snapShot.data?.docs.length);
                  switch(snapShot.connectionState){
                    case ConnectionState.none:
                      return const Text("NOne...");
                    case ConnectionState.waiting:
                     return const SizedBox(
                       height: 150,child: Center(child: CircularProgressIndicator()),);
                    case ConnectionState.active:
                      return const SizedBox(
                        height: 150,child: Center(child: CircularProgressIndicator()),);
                    case ConnectionState.done:
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(Icons.category,color: Colors.white,size: 24,),
                                const SizedBox(width: 8,),
                                const Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Categories())
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xff8B8B8B),
                                    ),
                                    child: const Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                      child: Row(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("see all",style: TextStyle(color: Colors.white,fontSize: 15),),
                                          Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapShot.data?.docs.length??0,//categoryName.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (c)=>CategoryProductsScreen(
                                            categoryId:snapShot.data?.docs[index]['id'],
                                            categoryName: snapShot.data?.docs[index]['name'],

                                        )));
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 32,
                                          backgroundImage: NetworkImage(
                                            snapShot.data?.docs[index]['image']??"",
                                          ),

                                        ),
                                        const SizedBox(height: 10,),
                                        Text(snapShot.data?.docs[index]['name'],style: const TextStyle(color: Color(0xffC4C4C4),fontSize: 15,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                  }
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.percent,color: Colors.white,size: 32,),
                  SizedBox(width: 8,),
                  Text("Offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
              ),
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
               future: FirebaseFirestore.instance.collection("products").where('has_offer',isEqualTo: true).get(),
                  builder: (context, snapshot) {
                 switch (snapshot.connectionState){
                   case ConnectionState.none:
                     return const Text("none");
                   case ConnectionState.waiting:
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   case ConnectionState.active:
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   case ConnectionState.done:
                   return  SizedBox(
                     height: 160,
                     child: ListView.builder(
                       physics: const BouncingScrollPhysics(),
                       padding: const EdgeInsets.symmetric(horizontal: 8),
                       scrollDirection: Axis.horizontal,
                       itemCount: snapshot.data?.docs.length,
                       itemBuilder: (context, index) {
                         return Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16),
                           child: InkWell(
                             onTap: (){
                               Navigator.push(context,
                               MaterialPageRoute(builder: (c)=>ProductDetailsScreen("", snapshot.data!.docs[index])));
                             },
                             child: Container(

                               width: 290,
                               height: 148,
                               decoration: BoxDecoration(
                                   image: DecorationImage(
                                     image: NetworkImage(snapshot.data?.docs[index]['image']),
                                     fit: BoxFit.cover,
                                   ),
                                   color: Colors.red,
                                   borderRadius: BorderRadius.circular(20)
                               ),
                             ),
                           ),
                         );
                       },
                     ),
                   );
                 }
                  }
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.percent,color: Colors.white,size: 32,),
                    SizedBox(width: 8,),
                    Text("Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
              ),
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance.collection("products").where('cart_count', isGreaterThan: 10).get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState){
                      case ConnectionState.none:
                        return const Text("none");
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        return  SizedBox(
                          height: 160,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c)=>ProductDetailsScreen("", snapshot.data!.docs[index])));
                                  },
                                  child: Container(
                                    width: 290,
                                    height: 148,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot.data?.docs[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                    }
                  }
              ),
            ],
          ),
        );
      },
    );
  }
}