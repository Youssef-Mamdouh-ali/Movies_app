import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;

  final String email ;
  final String password;

  UserModel({  required this.uid, required this.email, required this.password});
   final FirebaseAuth auth = FirebaseAuth.instance;

   Future<UserCredential> login() async {
     return await auth.signInWithEmailAndPassword(
       email: email,
       password: password,
     );
   }


}
