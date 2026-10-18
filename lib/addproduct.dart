
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/products.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  @override
  Widget build(BuildContext context) {
    Future<void>Addproduct()async{
      CollectionReference productRef = FirebaseFirestore.instance.collection("products");
      for(var product in products){
        await productRef.add(product);
      }
    }
      
    return Scaffold(
      body: ElevatedButton(onPressed: (){
        Addproduct();
      }, child: Text("addproduct")),
    );
  }
}