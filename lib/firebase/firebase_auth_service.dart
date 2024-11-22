import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final googlesignin = GoogleSignIn();
  final Logger _logger = Logger();

  signinwithgoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googlesignin.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final user = await _auth.signInWithCredential(credential);
        final idToken = await user.user?.getIdToken();
      }
    } on FirebaseAuthException catch (e) {
      _logger.d(e.toString());
    }
  }

  signout() async {
    await _auth.signOut();
    await googlesignin.signOut();
  }

  signwithemailandpassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _logger.d(cred);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      _logger.d('code => ${e.code}');
      switch (e.code) {
        case 'user-not-found':
          _logger.d('Akun tidak ditemukan.');
           throw ('Akun tidak ditemukan.');
        case 'invalid-credential':
          _logger.d('Akun atau kata sandi anda salah.');
          throw ('Akun atau kata sandi anda salah.');
        case 'invalid-email':
          _logger.d('Format email tidak valid.');
          throw ('Format email tidak valid.');
        case 'user-disabled':
          _logger.d('Akun untuk email $email telah dinonaktifkan.');
          throw ('Akun untuk email $email telah dinonaktifkan.');
        case 'too-many-requests':
          _logger.d(
              'Anda telah melakukan banyak percobaan login. Silahkan coba lagi dalam beberapa saat.');
          throw (
              'Anda telah melakukan banyak percobaan login. Silahkan coba lagi dalam beberapa saat.');
        default:
          _logger.d(e.toString());
          break;
      }
      _logger.d(e.toString());
    }
    return null;
  }

  /// Signup with email and username.
  ///
  /// It creates a new user using the given email and password, and
  /// then updates the user's display name to the given username.
  ///
  /// If the user was created successfully, it returns the user object.
  /// Otherwise, it returns null.
  ///
  Future<User?> signupwithemailanduser(
      String email, String username, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      await user!.updateDisplayName(username);
      await user.reload();
      _logger.d(user);
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      _logger.d(e.toString());
    }
    return null;
  }
}
