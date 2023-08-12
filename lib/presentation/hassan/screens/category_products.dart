import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r7_first_app/presentation/hassan/screens/product_details_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const CategoryProductsScreen( {required this.categoryName,
  required this.categoryId,
  Key? key}) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffA71E27),
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: Search());
              }),
          const SizedBox(
            width: 16,
          ),
          const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection("products").where('category_id',
          isEqualTo: widget.categoryId
        ).get(),
        builder: (context, snapShot) {
          print(snapShot.data?.docs.length);
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              return Text("NOne...");
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    scrollDirection: Axis.vertical,
                    itemCount: snapShot.data?.docs.length??0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ProductDetailsScreen(
                                widget.categoryName,
                                snapShot.data!.docs[index]
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          height: 150,
                          // padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    child: Container(
                                      height: 200,
                                      child: Image.network(
                                        snapShot.data?.docs[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    child: Center(
                                        child: Text(
                                      snapShot.data?.docs[index]['name'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                    decoration: BoxDecoration(
                                      color: Color(0xffA71E27),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder:(context, index){
                      return SizedBox(height: 16,);
                    },
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
