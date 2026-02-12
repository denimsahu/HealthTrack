import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: 35, weight: 90, color: Colors.black,))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Today's Insights",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/patient_screen");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.amberAccent,
                  ),
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.95,
                child: Center(child: Text("Total Patients", style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: Divider(thickness: 5,radius: BorderRadius.circular(100),)
              ),
            GestureDetector(
              onTap: () {
                
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent,
                  ),
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.95,
                child: Center(child: Text("Recent Reports", style:TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
              ),
            )
          ],
        ),
      )
    );
  }
}