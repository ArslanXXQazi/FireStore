import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fetch Data',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
          future:FirebaseFirestore.instance.collection('Information').get(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator(),);
              }
            if(!snapshot.hasData)
              {
                return Center( child: Text("No Data Found"),);
              }
            final docs=snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context,index){
                return Container(
                  height: height*.3,
                  width: width*.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
