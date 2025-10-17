import 'dart:convert';
import 'dart:io';

import 'package:contact_book/db/db.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _image==null?null:FileImage(_image!),
                  radius: 80,
                  backgroundColor: Colors.amber,
                ),
                Positioned(
                  top:75,
                  right: 30,
                  child: GestureDetector(
                    onTap: () async {
                      ImagePicker picker=ImagePicker();
                    XFile? _pickedImage  =await picker.pickImage(source: ImageSource.camera);
                    if(_pickedImage!=null){
                      _image=File(_pickedImage.path);
                      setState(() {
                        
                      });
                    }
                    },
                    child: Icon(Icons.camera_alt,size: 35,)))
              ],
            ),
            TextFormField(controller: nameController,
            decoration: InputDecoration(
              prefix: Icon(Icons.person),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Name',
              labelText: 'Name'
            ),
            ),
            TextFormField(controller: phoneController,
            
            decoration: InputDecoration(
              prefix: Icon(Icons.phone),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Phone',
              labelText: 'Phone'
            ),
            ),
            TextFormField(controller: emailController,
            
            decoration: InputDecoration(
              prefix: Icon(Icons.email),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Email',
              labelText: 'Email'
            ),
            ),
            ElevatedButton(onPressed: () async {
              String ?base64String;
              String ?email;
              String name=nameController.text;
              String phoneNum=phoneController.text;
              if(_image!=null){
                  base64String =base64Encode( await _image!.readAsBytes() as List<int>);
              }
              if(!emailController.text.isEmpty){
                email=emailController.text;
              }
             int id=  await DBHelper.instance.insertRaw(name, phoneNum,base64String, email);
               if(id>0)
               print('Data inserted successfully');
            }, child: Text('Save',style: TextStyle(fontSize: 20),))
          ],
        )),
      ),
    );
  }
}