import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  // Pick a single gallery image
  static Future<XFile?> pickGalleryItem() async {
    if (kIsWeb) {
      return await _pickSingleImageWeb();
    } else {
      return await _pickSingleImageMobile();
    }
  }

  // Upload a single image to Firebase Storage
  static Future<String?> uploadImage(XFile file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("uploads/$fileName");

      if (kIsWeb) {
        UploadTask uploadTask = ref.putData(await file.readAsBytes());
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      } else {
        File localFile = File(file.path);
        UploadTask uploadTask = ref.putFile(localFile);
        TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  // Pick a single image
  static Future<XFile?> pickSingleImage() async {
    if (kIsWeb) {
      return await _pickSingleImageWeb();
    } else {
      return await _pickSingleImageMobile();
    }
  }

  // Pick multiple images
  static Future<List<XFile>?> pickMultiImage() async {
    if (kIsWeb) {
      return await _pickMultiImageWeb();
    } else {
      return await _pickMultiImageMobile();
    }
  }

  // Upload multiple images to Firebase Storage
  static Future<List<String>> uploadMultipleImages(List<XFile> files) async {
    List<String> downloadUrls = [];

    for (XFile file in files) {
      String? url = await uploadImage(file);
      if (url != null) {
        downloadUrls.add(url);
      }
    }

    return downloadUrls;
  }

  // Private method to pick a single image on mobile
  static Future<XFile?> _pickSingleImageMobile() async {
    try {
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      debugPrint("Error picking single image on mobile: $e");
      return null;
    }
  }

  // Private method to pick multiple images on mobile
  static Future<List<XFile>?> _pickMultiImageMobile() async {
    try {
      return await _picker.pickMultiImage();
    } catch (e) {
      debugPrint("Error picking multiple images on mobile: $e");
      return null;
    }
  }

  // Private method to pick a single image on web
  static Future<XFile?> _pickSingleImageWeb() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result != null && result.files.single.bytes != null) {
        return XFile.fromData(result.files.single.bytes!,
            name: result.files.single.name);
      }
      return null;
    } catch (e) {
      debugPrint("Error picking single image on web: $e");
      return null;
    }
  }

  // Private method to pick multiple images on web
  static Future<List<XFile>?> _pickMultiImageWeb() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);

      if (result != null && result.files.isNotEmpty) {
        return result.files
            .map((file) => XFile.fromData(file.bytes!, name: file.name))
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint("Error picking multiple images on web: $e");
      return null;
    }
  }
}
