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
        leading: InkWell(
          onTap: (){},
          child: Icon(Icons.menu,color: Colors.white,size: 32,),
        ),
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
    );
  }
}