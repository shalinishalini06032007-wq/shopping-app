import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/myorders.dart';
import 'package:flutter_application_6/products.dart';


class Settingspage extends StatefulWidget {

  final Map<String,dynamic> product;
  const Settingspage({super.key,required this.product});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  int Count = 1;
  

  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> product = widget.product;

        return Scaffold(
      appBar: AppBar(
        title: Text('Order summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(image:DecorationImage(image: NetworkImage(product['image'],),fit: BoxFit.cover) ),
           ),
           SizedBox(height: 10,),
           Text(product['name'],style: TextStyle(fontSize: 18),),
           SizedBox(height: 10,),
           Text('₹${product['price']*Count}'),
           SizedBox(height: 10,),
           Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 40)
                ),
                onPressed: (){
                setState(() {
                  Count = Count - 1;
                });
              }, child: Text('-',style: TextStyle(fontWeight: FontWeight.bold),)),
              SizedBox(width: 10,),
              Text(Count.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 40)
                ),
                onPressed: (){
                setState(() {
                  Count = Count + 1;
                });
              }, child: Text('+',style: TextStyle(fontWeight: FontWeight.bold),))
            ],
           ),
           SizedBox(height: 20,),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               GestureDetector(
                onTap: () async{
                  await FirebaseFirestore.instance.collection("orders").add({
                   'name':product['name'],
                   'price':product['price'],
                   'quantity':Count,
                   'total':product['price']*Count,
                   'image':product['image'],
                   'orderTime': FieldValue.serverTimestamp(),

                  });  
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.white, content: Row(children: [
                    Icon(Icons.check,color: Colors.green,),
                    Text("Order confirmed successfully",style: TextStyle(color: Colors.black),)
                  ],)));
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const Myorders()));
                },
                 child: Container(
                  padding: EdgeInsets.all(12),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(color: Colors.lightBlue,borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text("confirm order",style: TextStyle(color: Colors.black),)),
                 ),
               ),
             ],
           ) 
          ],
        ),
      ),
    );
  }
}