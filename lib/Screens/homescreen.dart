import 'package:contact_book/Screens/newcontact.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return NewContactScreen();
      }));

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
              prefix: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
           ),
           Expanded(child: Container(

           )
           )
          ],

        ),
      
      )
    );
  }
}