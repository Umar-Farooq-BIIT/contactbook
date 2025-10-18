import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
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
  String ?base64String;
  Future<String> compressAndEncodeImage(File imageFile) async {
  // Read image bytes
  final bytes = await imageFile.readAsBytes();

  // Decode image
  img.Image? original = img.decodeImage(bytes);
  if (original == null) throw Exception("Failed to decode image");

  // Resize image to smaller width (e.g., 400 px)
  final resized = img.copyResize(original, width: 400);

  // Re-encode as JPEG with lower quality (0–100)
  final compressed = img.encodeJpg(resized, quality: 70);

  // Convert to Base64
  return base64Encode(compressed);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(child: Column(
          spacing: 20 ,
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
             
              String ?email;
              String name=nameController.text;
              String phoneNum=phoneController.text;
              if(_image!=null){
                base64String= await compressAndEncodeImage(_image!);
              }
            
              if(!emailController.text.isEmpty){
                email=emailController.text;
              }
             int id=  await DBHelper.instance.insertRaw(name, phoneNum,base64String, email);
               if(id>0){
               await ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data inserted..'))
                );
                Navigator.pop(context);
               }
               print('Data inserted successfully');
            }, child: Text('Save',style: TextStyle(fontSize: 20),))
          ],
        )),
      ),
    );
  }
}