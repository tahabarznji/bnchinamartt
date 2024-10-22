// lib/services/firebase_storage_service.dart

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _folder;

  FirebaseStorageService({String folder = 'uploads'}) : _folder = folder;

  Future<String> uploadFile(File file, {String? fileName}) async {
    try {
      String uniqueFileName = fileName ?? const Uuid().v4();
      Reference ref = _storage.ref().child('$_folder/$uniqueFileName');
      await ref.putFile(file);
      final String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      rethrow;
    }
  }

  /// Downloads a file's URL from Firebase Storage
  Future<String> getDownloadURL(String fileName) async {
    try {
      Reference ref = _storage.ref().child('$_folder/$fileName');
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a file from Firebase Storage
  Future<void> deleteFile(String fileName) async {
    try {
      Reference ref = _storage.ref().child('$_folder/$fileName');
      await ref.delete();
    } catch (e) {
      debugPrint('Error deleting file: $e');

      rethrow;
    }
  }

  Future<void> deleteFileWithURl(String fileUrl) async {
    try {
      Reference ref = _storage.refFromURL(fileUrl);

      await ref.delete();
      debugPrint('The file has deleted successfully');
    } catch (e) {
      debugPrint('error : $e');
    }
  }

  /// Lists all files in the storage folder
  Future<ListResult> listFiles() async {
    try {
      Reference ref = _storage.ref().child(_folder);
      ListResult result = await ref.listAll();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
