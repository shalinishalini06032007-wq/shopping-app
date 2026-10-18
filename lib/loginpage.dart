import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_6/homepage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller =TextEditingController();
    TextEditingController passwordcontroller =TextEditingController();

    FirebaseAuth auth= FirebaseAuth.instance;

    Future<void>SignIn() async{
      try{
        await auth.createUserWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [
          Icon(Icons.check),
          Text("Register Successfully")
        ],)));
      }
      catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [
          Icon(Icons.cancel),
          Text("registeration failed")
        ],)));
      }
    }
    Future<void>Login()async{
      try{
        await auth.signInWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [
          Icon(Icons.check),
          Text("Login Successfully")
        ],)));
      }
      catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(children: [
          Icon(Icons.cancel),
          Text("registeration failed")
        ],)));
      
      }
    }
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'enter your mail'),
              controller: emailcontroller,
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'enter your password'),
              controller: passwordcontroller,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              SignIn();
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Homepage()));
              
            }, child: Text("SingIn") ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              Login();
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Homepage()));
            }, child: Text("login"))
      
          ],
        ),
    ),
    );
  }
}