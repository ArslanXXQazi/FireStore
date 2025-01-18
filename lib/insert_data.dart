import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/fetch_data.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchData()));
        },
          backgroundColor: Colors.green,
          child: const Text('Fetch ',style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,
          ),),),
      ],),
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
                  await firestore.collection('Information').add({
                    'Email':emailController.text,
                    'Name':nameController.text,
                    'Father Name':fatherController.text,
                  });
                  loading=false;
                  setState(() {
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Data Added Successfully')));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Please Enter Your Data'),
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
                    SnackBar(content:  Text('Error$e'),
                      action: SnackBarAction(label: 'Cancel', onPressed: (){}),
                    ));
              }

            },
            style:  ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(300, 50),
            ),
            child:const Text(
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
