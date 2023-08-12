import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r7_first_app/presentation/hassan/widgets/appbar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String categoryMame;
  QueryDocumentSnapshot<Map<String, dynamic>> productDetails;
  ProductDetailsScreen(this.categoryMame,this.productDetails,{Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: CustomAppBarWidget(
        title: widget.categoryMame,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    alignment: Alignment.bottomCenter,
                    height: 340,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.shopping_cart,size: 30,color: Color(0xffA71E27),),
                            Text(widget.productDetails['cart_count'].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffA71E27)
                            ),)
                          ],
                        ),
                        SizedBox(width: 30,),
                        Row(
                          children: [
                            Icon(Icons.favorite,size: 30,color: Color(0xffA71E27),),
                            Text(widget.productDetails['fav_count'].toString(),
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffA71E27)
                              ),)
                          ],
                        ),                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
                    alignment: Alignment.bottomCenter,
                    height: 275,
                    color: Color(0xffA71E27),
                    child: Row(
                      children: [
                        Text(widget.productDetails['name'],
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.favorite_border,
                        size: 23,
                          color: Colors.white,
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Container(
                            width: 120,
                            height: 40,
                            color: Colors.white,
                            child: Center(
                              child: Text("${widget.productDetails['price'].toString()} SAR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color(0xffA71E27),
                              ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child:Image.network(
                    widget.productDetails['image'].toString(),
                    fit: BoxFit.fill,width: double.maxFinite,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text("Like This",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          SizedBox(height: 20,),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("products").where('id' ,isNotEqualTo: widget.productDetails['id']).
            where('category_id' ,isEqualTo: widget.productDetails['category_id']).get(),
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return const Text("none");
                case ConnectionState.waiting:
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                case ConnectionState.active:
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                case ConnectionState.done:
                  return  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length??0,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: (){
                              widget.productDetails=snapshot.data!.docs[index];
                              setState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                width: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      child:Image.network(
                                        snapshot.data?.docs[index]['image'],
                                        fit: BoxFit.fill,width: double.maxFinite,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text("${snapshot.data?.docs[index]['name']}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),),
                                              Text("${snapshot.data?.docs[index]['price']} LE",style:
                                              const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffA71E27),

                                              ),),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Icon(Icons.favorite_border,size: 35,color: Colors.grey,)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },),
                  );

              }
            },
          ),

          SizedBox(height: 30,),
        ],
      ),
      bottomNavigationBar:  ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        child: Container(
          color: Colors.white,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      onTap: (){
                        Map<String, dynamic> cartItem = widget.productDetails.data();
                        cartItem.addAll({"quantity":counter});
                        FirebaseFirestore.instance.collection("users")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('cart').add(cartItem);
                      },
                      child: Container(
                        color: Color(0xffA71E27),
                        height: 38,
                        width: 100,
                        child: Center(
                          child: Text("add to cart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18
                            ),),
                        ),
                      ),
                    ),

                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(counter>1){
                              counter--;
                            }
                          });
                        },
                        child: Icon(Icons.indeterminate_check_box_outlined,
                          color: Color(0xffA71E27),
                          size: 38,),
                      ),
                      Text("$counter",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: (){

                          setState(() {
                            counter++;
                          });

                        },
                        child: Icon(Icons.add_box_outlined,
                          color: Color(0xffA71E27),
                          size: 38,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
