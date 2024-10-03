import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> changePassword({required String newPassword}) async {
    if (currentUser == null) return; // Check if user is logged in

    try {
      await _auth.currentUser!.updatePassword(newPassword); // Update password
      print("Password updated successfully.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password provided is too weak.");
      } else if (e.code == 'requires-recent-login') {
        print(
            "The user must re-authenticate before this operation can be performed.");
      } else {
        print("Failed to update password: ${e.message}");
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }
}
