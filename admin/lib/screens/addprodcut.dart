import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_deliver/component/customButton.dart';
import 'package:medi_deliver/component/customTextField2.dart';
import 'package:medi_deliver/screens/hom_page.dart';
import 'package:path/path.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? name;
  int? price;
  String? description;
  String? category;
  String? quantity;
  File? file;
  String? url;
  var db = FirebaseFirestore.instance;
  GlobalKey<FormState> c = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return homPage();
              },
            ));
          },
        ),
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Amiko'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: c,
          child: ListView(
            children: [
              GestureDetector(
                  onTap: () async {
                    await imagePicker();
                  },
                  child: Container(
                    height: 60,
                    width: 70,
                    child: Image.asset('asset/images/profile.png'),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // fontFamily: 'Amiko',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              CustomTextFeild2(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null; // Return null if input is valid
                },
                obscureText: false,
                borderColor: Colors.white,
                onChanged: (value) {
                  name = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // fontFamily: 'Amiko',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              CustomTextFeild2(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  for (final character in value.characters) {
                    final codeUnit = character.toString().codeUnitAt(0);
                    if (codeUnit < 48 ||
                        (codeUnit > 57 && codeUnit < 1632) ||
                        codeUnit > 1641) {
                      return 'Only Arabic or English numbers are allowed';
                    }
                  }
                  return null; // Return null if input is valid
                },
                obscureText: false,
                borderColor: Colors.white,
                onChanged: (value) {
                  price = int.parse(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // fontFamily: 'Amiko',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              CustomTextFeild2(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }

                  return null; // Return null if input is valid
                },
                obscureText: false,
                borderColor: Colors.white,
                onChanged: (value) {
                  description = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // fontFamily: 'Amiko',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              CustomTextFeild2(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }

                  return null; // Return null if input is valid
                },
                obscureText: false,
                borderColor: Colors.white,
                onChanged: (value) {
                  category = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      color: Color(0xff7A869A),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // fontFamily: 'Amiko',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              CustomTextFeild2(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }

                  // Regular expression to match Arabic or English numbers
                  for (final character in value.characters) {
                    final codeUnit = character.toString().codeUnitAt(0);
                    if (codeUnit < 48 ||
                        (codeUnit > 57 && codeUnit < 1632) ||
                        codeUnit > 1641) {
                      return 'Only Arabic or English numbers are allowed';
                    }
                  }

                  return null; // Return null if input is valid
                },
                obscureText: false,
                borderColor: Colors.white,
                onChanged: (value) {
                  quantity = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                text: 'Save Product',
                onTap: () {
                  if (c.currentState!.validate()) {
                    addNewProduct();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {});
      var imagename = basename(image.path);
      var storageRef = FirebaseStorage.instance.ref(imagename);
      await storageRef.putFile(file!);
      url = await storageRef.getDownloadURL();
    }
  }

  Future<void> addNewProduct() async {
    Map<String, dynamic> newproduct = {
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'quantity': quantity,
      'image': url
    };
    db.collection('Products').add(newproduct);
    // }
  }
}
