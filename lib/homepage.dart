import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/iphone.dart';
import 'package:flutter_application_6/myorders.dart';
import 'package:flutter_application_6/products.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.receipt_long_outlined),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const Myorders()));
                    },
                    child: Text('my orders',style: TextStyle(fontSize: 16),)),
                  SizedBox(width: 15,),
                  Text("Favourites",style: TextStyle(fontSize: 16),),
                  Icon(Icons.favorite_outline)
                ],
              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: products.length, itemBuilder:(context,index){
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListTile(
                       leading: SizedBox(
                        width: 70,
                       height: 70,
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(8),
                           child: Image.network(product["image"],
                           fit: BoxFit.cover,),
                         ),
                       ),
                       title: Text(product["name"]),
                       subtitle: Text("₹${product['price']}"), 
                       onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Iphone(product: product,)));
                       },
                       
                    ),
                  );
                  
                } ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}