import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateData extends StatefulWidget {
  final docId;
   UpdateData({super.key,required this.docId});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController fatherController=TextEditingController();
  TextEditingController rollnumerController=TextEditingController();
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  bool loading=false;

  Future<void> _fetchExistingData()async
  {
    try{
      final doc = await firestore.collection('Information').doc(widget.docId).get();
      if(doc.exists)
        {
          setState(() {
            nameController.text=doc["name"]??'';
            emailController.text=doc['Email']??'';
            fatherController.text=doc["Father Name"]??'';
            rollnumerController.text=doc['Roll Number']??'';
          });
        }
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }


  Future<void> _updateData()async
  {
   try
       {
         await firestore.collection('Information').doc(widget.docId).update({
           'Name': nameController.text,
           'Email': emailController.text,
           'Father Name': fatherController.text,
           'Roll Number': rollnumerController.text,
         });
         setState(() {
           
         });
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Data Updated Successfully')),
         );
         Navigator.pop(context);
       }
       catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating data: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Update Data',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:width*.03,vertical: height*.02),
        child: Column(
          children: [
            Text(
              'Update Student Information',
              style: GoogleFonts.b612Mono(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
              ),
            ),
            SizedBox(height: height*.02,),
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                ),
              ),
            ),
            //==================================================>>>>2nd Text field
            SizedBox(height: height*.02,),
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                ),
              ),
            ),

            //==================================================>>>>3rd Text field
            SizedBox(height: height*.02,),
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                ),
              ),
            ),

            //==================================================>>>>4th Text field
            SizedBox(height: height*.02,),
            TextFormField(
              controller: rollnumerController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Your Roll Number',
                labelText: 'Enter Your Roll Number',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey,width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                ),
              ),
            ),
            SizedBox(height: height*.02,),

            //==================================================>>>>ADD Button
            loading?CircularProgressIndicator()
                :ElevatedButton(
              onPressed: () {
                _updateData();
              },
              style:  ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(width*1,height*.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child:const Text(
                'Update',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),

            ),
          ],),
      ),
    );
  }
}
