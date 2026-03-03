import 'package:firebase_auth/firebase_auth.dart';

import '../login/data/login_data.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= Register =================
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;
    await user.updateDisplayName(name);

    return UserModel(
      uid: user.uid,
      email: user.email!,
      password: password,
    );
  }

  // ================= Login =================
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;
    return UserModel(
      uid: user.uid,
      email: user.email!,
      password: password,

    );
  }

  // ================= Logout =================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ================= Current User (optional but useful) =================
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      password: '',
    );
  }
}
