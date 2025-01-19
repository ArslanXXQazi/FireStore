import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
final FirebaseFirestore firesotre=FirebaseFirestore.instance;
  Future<void>DeleteData( String docId)async{
    try{
      await firesotre.collection('Information').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Document Deleted Successfully")),
      );
      setState(() {
      });
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Deleting Document $e"))
      );
    }
  }

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
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*.02,horizontal: width*.04),
                  child: GestureDetector(
                    onTap: (){
                      DeleteData(docs[index].id);
                    },
                    child: Container(
                      height: height*.3,
                      width: width*.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green,width: 2),
                      ),
                      child: Center(
                        child: Padding(
                          padding:EdgeInsets.symmetric(horizontal: width*.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text('Student Information',
                              style: GoogleFonts.b612Mono(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                              SizedBox(height: height*.02,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Roll Number',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                  Text(docs[index]['Roll Number'],
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue
                                    ),
                                  ),
                                ],),
                            SizedBox(height: height*.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Text(
                                  'Name',
                                style: TextStyle(
                                  fontSize: 17
                                ),
                              ),
                              Text(docs[index]['Name'],
                                style: TextStyle(
                                    fontSize: 17,
                                  color: Colors.blue
                                ),
                              ),
                            ],),
                            SizedBox(height: height*.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Father Name',
                            style: TextStyle(
                                fontSize: 17
                            ),
                                ),
                                Text(docs[index]['Father Name'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue
                                  ),
                                ),
                              ],),
                            SizedBox(height: height*.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Email',
                                  style: TextStyle(
                                      fontSize: 17
                                  ),
                                ),

                                Text(docs[index]['Email'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.red
                                  ),
                                ),
                              ],),
                          ],),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
