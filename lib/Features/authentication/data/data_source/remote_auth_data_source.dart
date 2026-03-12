import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app_project/Features/authentication/domain/entities/sign_up_request.dart';
import '../../domain/entities/sign_in_request.dart';
import 'auth_data_source.dart';

class RemoteAuthDataSource implements AuthDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signIn({required SignInRequest data}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('User not found');
      } else if (e.code == 'wrong-password') {
        throw Exception('The password is incorrect');
      }
      throw Exception(e.message ?? 'Something went wrong');
    }
  }

  @override
  Future<void> signUp({required SignUpRequest data}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      String uid = credential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uId': uid,
        'name': data.name,
        'email': data.email,
        'phone': data.phone,
        'avatar': data.avatar,
        'createdAt': DateTime.now().toIso8601String(),
      });

      await credential.user?.updateDisplayName(data.name);

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Sign up failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    try {

      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Error occurred");
    }
  }
}