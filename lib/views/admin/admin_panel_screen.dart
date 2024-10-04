import 'dart:io';

import 'package:bnchinamartt/core/services/firebase_storage_service.dart';
import 'package:bnchinamartt/core/services/image_picker_service.dart';
import 'package:bnchinamartt/core/services/product_firestore_service.dart';
import 'package:bnchinamartt/models/product_data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<String> productCategories = [
    'Snaks',
    'drinks',
    'fruits',
    'coffee',
    'Greens',
  ];
  String? _selectedCategory;

  XFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: productCategories
                      .map((category) => DropdownMenuItem<String>(
                          value: category, child: Text(category)))
                      .toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  controller: _descriptionController,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                if (pickedFile != null) Image.file(File(pickedFile!.path)),
                ElevatedButton(
                  child: const Text('Pick Image'),
                  onPressed: () async {
                    pickedFile = await ImageService.pickSingleImage();
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        pickedFile != null) {
                      final downlodUrl = await FirebaseStorageService()
                          .uploadFile(File(pickedFile!.path),
                              fileName: 'Products');
                      final product = ProductDataModel(
                          id: '',
                          name: _nameController.text,
                          imgPath: downlodUrl,
                          category: _selectedCategory ?? '',
                          price: double.tryParse(_priceController.text) ?? 0,
                          foodDetails: _descriptionController.text);
                      ProductFirestoreService().addProduct(product);

                      // Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
