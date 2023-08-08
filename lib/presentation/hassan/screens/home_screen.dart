import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import 'categories.dart';
import 'drawer_screen.dart';
class HomeScreen extends StatefulWidget{

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;

  List <String> offers = ["https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg",
    "https://www.gitsfood.com/wp-content/uploads/2021/11/Complete-Snackmix-Combo-600x600.jpg"];

  List <String> popularProductsImage =[
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
    "https://www.thecookierookie.com/wp-content/uploads/2023/04/stovetop-burgers-recipe-2-960x1200.jpg",
  ];

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
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title: const Text("24 Express",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),),
        actions: [
           IconButton(icon: const Icon(Icons.search), onPressed: (){
             // showSearch(context: context, delegate: Search());
           }),
          const SizedBox(width: 16,),
          const Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 32,),
          const SizedBox(width: 8,)
        ],
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
            currentIndex: current,
            onTap: (index){},
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection("categories").get(),
            builder: (context,snapShot){
              print(snapShot.data?.docs.length);
              switch(snapShot.connectionState){
                case ConnectionState.none:
                  return Text("NOne...");
                case ConnectionState.waiting:
                 return SizedBox(
                   height: 150,child: Center(child: CircularProgressIndicator()),);
                case ConnectionState.active:
                  return SizedBox(
                    height: 150,child: Center(child: CircularProgressIndicator()),);
                case ConnectionState.done:
                  return Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(16),
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
                                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
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
                        height: 150,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapShot.data?.docs.length??0,//categoryName.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            );
                          },
                        ),
                      ),
                    ],
                  );
                  break;
              }
            },
          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.percent,color: Colors.white,size: 32,),
              SizedBox(width: 8,),
              Text("Offers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            ],
          ),
          ),
          SizedBox(height: 160,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(

                    width: 290,
                    height: 148,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(offers[index]),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                );
              },

            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            child: Row(
              children: const [
                Icon(Icons.percent,color: Colors.white,size: 32,),
                SizedBox(width: 8,),
                Text("Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
          Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularProductsImage.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                  itemBuilder: (context,index){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(popularProductsImage[index]),
                      fit: BoxFit.cover
                    ),

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                );
                  }),
            ),
        ],
      ),
    );
  }
}