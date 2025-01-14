import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController=TextEditingController();
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'FireStore DataBase',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your Name',
            labelText: 'Enter your Name',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey,width: 2)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey,width: 2)
            ),
          ),
        ),
          ElevatedButton(
              onPressed: () async{
                try{
                  loading=true;
                  setState(() {

                  });
                  if(nameController.text.isNotEmpty){
                    await firestore.collection('Data').add({
                      'Data':nameController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Data Addes Succcessfuly')));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Enter Your Data'),
                          action: SnackBarAction(label: 'Cancel', onPressed: (){}),
                        ));
                  }
                }catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error$e'),
                        action: SnackBarAction(label: 'Cancel', onPressed: (){}),
                      ));
                }

              },
            style:  ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(300, 50),
            ),
              child: Text(
            'ADD',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),

          ),
      ],),
    );
  }
}
