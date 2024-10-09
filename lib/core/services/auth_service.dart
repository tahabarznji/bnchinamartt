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
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Future<void> changePassword({required String newPassword}) async {
  //   if (currentUser == null) return; // Check if user is logged in

  //   try {
  //     await _auth.currentUser!.updatePassword(newPassword); // Update password
  //     print("Password updated successfully.");
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print("The password provided is too weak.");
  //     } else if (e.code == 'requires-recent-login') {
  //       print(
  //           "The user must re-authenticate before this operation can be performed.");
  //     } else {
  //       print("Failed to update password: ${e.message}");
  //     }
  //   } catch (e) {
  //     print("An unexpected error occurred: $e");
  //   }
  // }
  Future<String?> changePasswordWithCurrentPassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Re-authenticate the user with the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // After successful re-authentication, update the password
        await user.updatePassword(newPassword);
        return null;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "The current password is invalid.";
      } else if (e.code == 'weak-password') {
        return "The new password is too weak.";
      } else {
        return "Error updating password";
      }
    } catch (e) {
      return null;
    }
  }
}
