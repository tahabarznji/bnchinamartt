import 'dart:io';

import 'package:bnchinamartt/core/services/firebase_storage_service.dart';
import 'package:bnchinamartt/core/services/image_picker_service.dart';
import 'package:bnchinamartt/core/services/product_firestore_service.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/custom_text_field.dart';
import 'package:bnchinamartt/models/product_data_model.dart';

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
    'Milk',
    'Meat',
    'Snaks',
    'Drinks',
    'Fruits',
    'Coffee',
    'Greens',
    'Bread',
    'Protein',
    'Seafood',
  ];
  String? _selectedCategory;

  XFile? pickedFile;
  Future<void> pickImage() async {
    pickedFile = await ImageService.pickSingleImage();
    setState(() {});
  }

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate() && pickedFile != null) {
      final downlodUrl = await FirebaseStorageService()
          .uploadFile(File(pickedFile!.path), fileName: 'Products');
      final product = ProductDataModel(
          id: '',
          name: _nameController.text,
          imgPath: downlodUrl,
          category: _selectedCategory ?? '',
          price: double.tryParse(_priceController.text) ?? 0,
          foodDetails: _descriptionController.text);
      await ProductFirestoreService().addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('Admin panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                    controller: _nameController,
                    hintText: 'Product Name',
                    validator: validatorUsername),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select category',
                    hintStyle: TextStyle(fontSize: 12, color: darkGreyColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    filled: true,
                    fillColor: greyColor,
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
                CustomTextField(
                  controller: _priceController,
                  hintText: 'Product Price',
                  keyboardType: TextInputType.number,
                  validator: (p0) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Product Discription',
                  validator: (value) {
                    return null;
                  },
                ),
                if (pickedFile != null) Image.file(File(pickedFile!.path)),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'Pick Image',
                  onPressed: pickImage,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  text: 'Add product',
                  onPressed: addProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
