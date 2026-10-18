import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/homepage.dart';
import 'package:flutter_application_6/products.dart';
import 'package:intl/intl.dart';

class Myorders extends StatefulWidget {
  
  const Myorders({super.key,});

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
  title: Text('My Orders'),
  leading: IconButton(
    icon: Icon(Icons.keyboard_arrow_left_outlined),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Homepage()));
    },
  ),
),
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!snapshot.hasData|| snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("no orders"),
            );
          }
          final orders = snapshot.data!.docs;
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: orders.length, 
            itemBuilder: ((context, index) {
              final Order = orders[index].data() as Map<String,dynamic>;
              print(Order);
              final Timestamp? orderTime = Order['orderTime'];
              return ListTile(
                title: Text(Order['name'].toString()),
                leading: SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8),
                    child: Image.network(Order['image'],fit: BoxFit.cover,)
                  ),
                ),
                subtitle: Text(
                  'Quantity: ${Order['quantity'] ?? 'Not available'}\n'
                  'Total: ₹${Order['total']}\n'
                  'Order Time: ${orderTime != null ?  DateFormat('dd MMM yyyy, hh:mm a').format(orderTime.toDate()) : 'N/A'}'
                ),
                trailing: IconButton(onPressed: ()async{
                  await orders[index].reference.delete();
                }, icon: Icon(Icons.delete,color: Colors.red,)),
              );
            }));
        },),
    )
    ); }
}