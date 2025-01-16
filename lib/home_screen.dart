import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController fatherController=TextEditingController();
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
          //==================================================>>>>1st Text field
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
          //==================================================>>>>2nd Text field
          SizedBox(height: 10,),
          TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your Email',
            labelText: 'Enter your Email',
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

          //==================================================>>>>3rd Text field
          SizedBox(height: 10,),
          TextFormField(
            controller: fatherController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Father Name',
              labelText: 'Enter Father Name',
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

          SizedBox(height: 20,),
          //==================================================>>>>ADD Button
          loading?CircularProgressIndicator()
              :ElevatedButton(
            onPressed: () async{
              try{
                loading=true;
                setState(() {

                });
                if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && fatherController.text.isNotEmpty){
                  await firestore.collection('Data').add({
                    'Email':emailController.text,
                    'Name':nameController.text,
                    'FatherName':fatherController,
                  });
                  loading=false;
                  setState(() {
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Data Addes Succcessfuly')));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter Your Data'),
                        action: SnackBarAction(label: 'Cancel', onPressed: (){}),
                      ));
                  loading=false;
                  setState(() {

                  });
                }
              }catch (e){
                loading=false;
                setState(() {

                });
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
