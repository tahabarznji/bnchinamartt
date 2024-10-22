import 'dart:io';

import 'package:bnchinamartt/core/services/firebase_storage_service.dart';
import 'package:bnchinamartt/core/services/image_picker_service.dart';
import 'package:bnchinamartt/core/services/product_firestore_service.dart';
import 'package:bnchinamartt/core/utils/colors.dart';
import 'package:bnchinamartt/core/utils/data.dart';
import 'package:bnchinamartt/core/utils/validators.dart';
import 'package:bnchinamartt/core/widgets/custom_button.dart';
import 'package:bnchinamartt/core/widgets/custom_text_field.dart';
import 'package:bnchinamartt/models/product_data_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isLoading = false;
  bool isTrending = false;

  String? _selectedCategory;

  XFile? pickedFile;
  Future<void> pickImage() async {
    pickedFile = await ImageService.pickSingleImage();
    setState(() {});
  }

  Future<void> addProduct() async {
    if (_formKey.currentState!.validate() && pickedFile != null) {
      setState(() {
        isLoading = true;
      });
      final downlodUrl = await FirebaseStorageService()
          .uploadFile(File(pickedFile!.path), fileName: 'Products');
      final product = ProductDataModel(
          id: '',
          name: _nameController.text,
          imgPath: downlodUrl,
          isTrending: isTrending,
          category: _selectedCategory ?? '',
          price: double.tryParse(_priceController.text) ?? 0,
          foodDetails: _descriptionController.text);
      await ProductFirestoreService().addProduct(product);
      _clearFields();

      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearFields() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _formKey.currentState?.reset();
    pickedFile = null;
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
                _buildCategoryDropdown(),
                // DropdownButtonFormField<String>(
                //   decoration: InputDecoration(
                //     hintText: 'Select category',
                //     hintStyle: TextStyle(fontSize: 12, color: darkGreyColor),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide: BorderSide.none,
                //     ),
                //     contentPadding: const EdgeInsets.symmetric(
                //         horizontal: 20, vertical: 15),
                //     filled: true,
                //     fillColor: greyColor,
                //   ),
                //   value: _selectedCategory,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedCategory = newValue;
                //     });
                //   },
                //   items: productCategories
                //       .map((category) => DropdownMenuItem<String>(
                //           value: category, child: Text(category)))
                //       .toList(),
                // ),
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
                _buildTrendingCheckbox(),
                // Row(
                //   children: [
                //     Checkbox(
                //       value: isTrending,
                //       activeColor: primaryColor,
                //       onChanged: (value) {
                //         setState(() {
                //           isTrending = value!;
                //         });
                //       },
                //     ),
                //     const Text('dose this product is trending ?'),
                //   ],
                // ),
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
                if (isLoading) ...{
                  const CircularProgressIndicator(),
                } else
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

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select Category',
        hintStyle: TextStyle(fontSize: 12, color: darkGreyColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: greyColor,
      ),
      value: _selectedCategory,
      onChanged: (String? newValue) =>
          setState(() => _selectedCategory = newValue),
      items: productCategories
          .map((category) =>
              DropdownMenuItem(value: category, child: Text(category)))
          .toList(),
    );
  }

  Widget _buildTrendingCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isTrending,
          activeColor: primaryColor,
          onChanged: (bool? value) =>
              setState(() => isTrending = value ?? false),
        ),
        const Text('Is this product trending?'),
      ],
    );
  }
}
