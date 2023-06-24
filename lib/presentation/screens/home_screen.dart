import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
final List<String> categoriesNames = [
  "Milk",
  "Vegatables",
  "Meat",
  "Sea Food",
  "Eggs",
];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: Color(0xffA71E27),
        // leading: InkWell(
        //   onTap: (){},
        //   child: Icon(Icons.menu,color: Colors.white,size: 32,),
        // ),
        title: Text("24 EXPRESS",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search,color: Colors.white,size: 32,),
          SizedBox(width: 24,),
          Icon(Icons.shopping_cart,color: Colors.white,size: 32,),
          SizedBox(width: 16,),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.category,color: Colors.white,size: 32,),
                SizedBox(width: 8,),
                Text("Categories ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: 24,
                  // width: 72,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff707070),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("see all",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 4.5,),
                      Icon(Icons.arrow_forward_ios,
                        color: Colors.white,size: 18,),

                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: categoriesNames.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 31,
                      ),
                      SizedBox(height: 5,),
                      Text(categoriesNames[index],
                        style: TextStyle(
                          color: Color(0xffC4C4C4),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor:Color(0xFF171717),
        child: Column(
          children: [
            Container(
              height: 148,
              color: Color(0xffA71E27),
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
                    onTap: (){},
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
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
          child: BottomNavigationBar(
            currentIndex: 1,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "Favourites",
              ),
            ],

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}