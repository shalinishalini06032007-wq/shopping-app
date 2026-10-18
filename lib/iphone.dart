import 'package:flutter/material.dart';
import 'package:flutter_application_6/products.dart';
import 'package:flutter_application_6/settingspage.dart';

class Iphone extends StatefulWidget {
   
  final Map<String,dynamic> product;

  const Iphone({super.key , required this.product});

  @override
  State<Iphone> createState() => _IphoneState();
}

class _IphoneState extends State<Iphone> {
     
     

  @override
  Widget build(BuildContext context) {
     
     final Map<String,dynamic> product = widget.product;

    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product['image']),fit: BoxFit.cover)), 
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(product['name'],style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Text("₹ ${product['price'].toString()} ",style: TextStyle(fontSize: 16),),
            SizedBox(height: 10,),
            Text('free delivery'),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Settingspage(product: product)));
            }, child: Text("Buy"))   
          ],
        ),
      ),
    );
  }
}