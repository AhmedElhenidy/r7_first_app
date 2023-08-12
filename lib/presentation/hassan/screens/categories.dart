import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import 'category_products.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: const CustomAppBarWidget(
        title: "Categories",
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
              return  GridView.builder(
                padding: EdgeInsets.all(16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapShot.data?.docs.length??0,
                  scrollDirection: Axis.vertical,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductsScreen(
                                 categoryName:  snapShot.data?.docs[index]['name'],
                                  categoryId:  snapShot.data?.docs[index]['id'],
                                ))
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child:  ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.network(
                                snapShot.data?.docs[index]['image'],
                             fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Text(
                              snapShot.data?.docs[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
          }
        },
      ),
    );
  }
}
