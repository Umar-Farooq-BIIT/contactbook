import 'dart:convert';

import 'package:contact_book/Screens/newcontact.dart';
import 'package:contact_book/db/db.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  bool isFetching=true;
  List<Map<String,dynamic>> phoneList=[];
  Future<void> _fetchAllRecords()async{
  phoneList = await DBHelper.instance.selectRaw();
  isFetching=false;
  setState(() {
    
  });
  }

  void initState(){
    _fetchAllRecords();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(onPressed: ()async{
     await Navigator.push(context, MaterialPageRoute(builder: (context){
        return NewContactScreen();
      }));
      _fetchAllRecords();

     },child: Text('+',style: TextStyle(fontSize: 20),),),
      appBar: AppBar(
        title: const Text('Contact Book'),
        backgroundColor: Colors.orange ,
        
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
           TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
           ),
           isFetching?Center(child: CircularProgressIndicator(),):
           phoneList.isEmpty?Center(child: Text('No record available'),):
           Expanded(child: Container(
            child: ListView.builder(
              itemCount: phoneList.length,
              itemBuilder: (context,index){
                Map<String,dynamic> singleRecord=phoneList[index];
                return Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.amber,
                        backgroundImage: singleRecord["imageString"]==null?null:
                                        MemoryImage(base64Decode(singleRecord["imageString"])),
                                
                      ),
                      SizedBox(width: 15,),
                      Column(
                        spacing: 4,
                        children: [
                          Text(singleRecord["name"]),
                          Text(singleRecord["number"]),
                          singleRecord["email"]!=null?Text(singleRecord["email"]):Text('')
                        ],
                      )

                    ],
                  ),
                );


              }),

           )
           )
          ],

        ),
      
      )
    );
  }
}