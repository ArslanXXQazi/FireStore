import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fetch Data',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
    future:FirebaseFirestore.instance.collection('Information').get() ,
    builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
      if (snapshot.connectionState==ConnectionState.waiting)
        {
          return Center();
        }
    })

          });
  }
}
