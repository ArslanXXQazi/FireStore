import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> DeleteData(String docId) async {
    try {
      await firestore.collection('Information').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Document Deleted Successfully")),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Deleting Document $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Fetch Data',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Information').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data Found"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * .02, horizontal: width * .04),
                child: GestureDetector(
                  onTap: () {
                    // Use Flutter's showDialog to display confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Are you sure you want to delete?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          actions: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                             ElevatedButton(
                               onPressed: () {
                                 DeleteData(docs[index].id);
                                 Navigator.of(context).pop(); // Close the dialog
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.red
                               ),
                               child: Text(
                                 'Delete',
                                 style: GoogleFonts.aBeeZee(
                                 fontSize: 15,
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold
                               ),
                               ),
                             ),
                             SizedBox(width: width*.02),
                             ElevatedButton(
                               onPressed: () {
                                 Navigator.of(context).pop(); // Close the dialog
                               },
                               child: Text(
                                 'Cancel',
                        style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                        ),
                               ),
                             ),
                           ],)
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: height * .3,
                    width: width * .7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * .04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Student Information',
                              style: GoogleFonts.b612Mono(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Roll Number',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  docs[index]['Roll Number'],
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  docs[index]['Name'],
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Father Name',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  docs[index]['Father Name'],
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  docs[index]['Email'],
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
