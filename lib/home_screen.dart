import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController=TextEditingController();

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
              onPressed: (){},
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
