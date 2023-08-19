import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r7_first_app/presentation/hassan/presetation_logic_holder/cart_cubit/cart_cubit.dart';
import 'package:r7_first_app/presentation/hassan/screens/product_details_screen.dart';

import 'home_screen.dart';

class UserCart extends StatefulWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartCubit>(context).getCartItems();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
          backgroundColor: const Color(0xffA71E27),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Your Cart",
              style:TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold) ),
          actions: [
            IconButton(icon: const Icon(Icons.search,size: 26,), onPressed: (){
              // var context;
              // showSearch(context: context, delegate: Search());
            }),
            IconButton(icon: const Icon(Icons.home_outlined,size: 26,), onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  (context) =>  HomeScreen(),), (route) => false);
            }),
          ]
      ),
      body: BlocBuilder<CartCubit,CartState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<CartCubit>(context);
            return state is CartItemLoadingState
            ?
            const Center(
              child: CircularProgressIndicator(),
            )
            :  state is CartItemErrorState?
            const Text("none")
            :
            cubit.cartItems.isEmpty
                ? const Center(
              child: Text('You Don\'t Have Items In Your Cart!' ,
                style: TextStyle(color: Color(0xffA71E27),
                  fontSize: 20,fontWeight: FontWeight.bold),),
            )
                :
            Column(
              children: [
               Expanded(
                 child:  GridView.builder(
                   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                   shrinkWrap: true,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       childAspectRatio: .6,
                       crossAxisCount: 2,
                       mainAxisSpacing: 16,
                       crossAxisSpacing: 16
                   ),
                   physics:  const BouncingScrollPhysics(),
                   // padding: EdgeInsets.all(16),
                   scrollDirection: Axis.vertical,
                   itemCount: cubit.cartItems.length,
                   itemBuilder: (context, index) {
                     return InkWell(
                       onTap: (){
                         // Navigator.push(context, MaterialPageRoute(
                         //   builder: (context) => ProductDetailsScreen("",
                         //       cubit.cartItems[index]),));
                       },
                       child: Column(
                         children: [
                           ClipRRect(
                             borderRadius: const BorderRadius.only(
                               topRight: Radius.circular(15),
                               topLeft: Radius.circular(15),
                             ),
                             child: SizedBox(
                               height: 150,
                               width: double.maxFinite,
                               child: Image.network( cubit.cartItems[index]['image'],
                                 fit: BoxFit.fill,),
                             ),
                           ),
                           ClipRRect(
                             borderRadius: const BorderRadius.only(
                               bottomRight: Radius.circular(15),
                               bottomLeft: Radius.circular(15),
                             ),
                             child: Container(
                               width: double.maxFinite,
                               color: Colors.white,
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                               child: Column(
                                 children: [
                                   const SizedBox(height: 5,),
                                   Text("${ cubit.cartItems[index]['name']}"
                                     ,style: const TextStyle(color: Colors.black,
                                         fontSize: 20,fontWeight: FontWeight.bold),),
                                   const SizedBox(height: 5,),
                                   Text('Quantity: ${ cubit.cartItems[index]['quantity']}',style: const TextStyle(color: Color(0xffA71E27),
                                       fontSize: 20,fontWeight: FontWeight.bold),),

                                   const SizedBox(height: 5,),
                                   Text('Total Cost: ${( cubit.cartItems[index]['quantity']as int)*
                                       ( cubit.cartItems[index]['price']as int)}'
                                     ,style: const TextStyle(color: Color(0xffA71E27),
                                         fontSize: 18,fontWeight: FontWeight.bold),),

                                   const SizedBox(height: 5,),
                                   InkWell(
                                     onTap: () {
                                       showDialog(context: context, builder: (context) {
                                         return  AlertDialog(
                                           title: const Text('Delete This Item?'),
                                           actions: [
                                             InkWell(
                                               onTap: () {
                                                 Navigator.pop(context);
                                               },
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(10),
                                                 child: Container(
                                                   padding: const EdgeInsets.all(10),
                                                   color:  const Color(0xffA71E27),
                                                   child:  const Text('Cancel',style:
                                                   TextStyle(color: Colors.white,
                                                       fontSize: 20,fontWeight: FontWeight.bold),),
                                                 ),
                                               ),
                                             ),
                                             InkWell(
                                               onTap: () {
                                                 FirebaseFirestore.instance.
                                                 collection("users")
                                                     .doc(FirebaseAuth.instance.currentUser?.uid)
                                                     .collection("cart")
                                                     .doc(cubit.cartItems[index].id).delete();
                                                 setState(() {
                                                 });
                                                 Navigator.pop(context);

                                               },
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(10),
                                                 child: Container(
                                                   padding: const EdgeInsets.all(10),
                                                   color:  const Color(0xffA71E27),
                                                   child:  const Text('Delete',style:
                                                   TextStyle(color: Colors.white,
                                                       fontSize: 20,fontWeight: FontWeight.bold),),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         );
                                       },);
                                     },
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(
                                           padding: const EdgeInsets.all(10),
                                           color:  const Color(0xffA71E27),
                                           child: Icon(Icons.delete_forever_rounded,size: 20,color: Colors.white,)
                                         // const Text('Delete',style:
                                         // TextStyle(color: Colors.white,
                                         //     fontSize: 20,fontWeight: FontWeight.bold),),
                                       ),
                                     ),
                                   ),
                                   const SizedBox(height: 5,)

                                 ],

                               ),
                             ),
                           )
                         ],
                       ),
                     );

                   },
                 ),
               ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color:  const Color(0xffA71E27),
                            child:  Center(
                              child: Text('${cubit.getTotalCost()}',style:
                              const TextStyle(color: Colors.white,
                                  fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color:  const Color(0xffA71E27),
                            child:  Center(
                              child: Text('Checkout',style:
                              const TextStyle(color: Colors.white,
                                  fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                )
              ],
            );
          }
      ),
    );

  }
}