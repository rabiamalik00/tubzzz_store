import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
// Result wrapper
// ─────────────────────────────────────────────
class AuthResult {
  final bool success;
  final String? errorMessage;
  final User? user;

  AuthResult({required this.success, this.errorMessage, this.user});
}

// ─────────────────────────────────────────────
// Firebase Auth Service
// ─────────────────────────────────────────────
class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Current user
  static User? get currentUser => _auth.currentUser;
  static bool get isLoggedIn => _auth.currentUser != null;
  static String get userName =>
      _auth.currentUser?.displayName ?? 'Beautiful User';
  static String get userEmail => _auth.currentUser?.email ?? '';
  static String get userPhoto => _auth.currentUser?.photoURL ?? '';

  // Auth state stream
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Email & Password Sign Up ─────────────────
  static Future<AuthResult> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await credential.user?.updateDisplayName(name.trim());
      await credential.user?.sendEmailVerification();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name.trim());

      return AuthResult(success: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, errorMessage: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
          success: false,
          errorMessage: 'Something went wrong. Please try again.');
    }
  }

  // ── Email & Password Login ───────────────────
  static Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult(success: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, errorMessage: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
          success: false,
          errorMessage: 'Login failed. Please try again.');
    }
  }

  // ── Google Sign In ───────────────────────────
  static Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult(
            success: false, errorMessage: 'Google sign-in was cancelled.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return AuthResult(success: true, user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, errorMessage: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
          success: false, errorMessage: 'Google sign-in failed. Please try again.');
    }
  }

  // ── Password Reset Email ─────────────────────
  static Future<AuthResult> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return AuthResult(success: true);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, errorMessage: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
          success: false, errorMessage: 'Failed to send reset email.');
    }
  }

  // ── Phone Number OTP ─────────────────────────
  static Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(_getErrorMessage(e.code));
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      onError('Failed to send OTP. Please try again.');
    }
  }

  static Future<AuthResult> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return AuthResult(success: true, user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, errorMessage: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
          success: false, errorMessage: 'OTP verification failed.');
    }
  }

  // ── Update Display Name ──────────────────────
  static Future<bool> updateDisplayName(String name) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ── Sign Out ─────────────────────────────────
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ── English Error Messages ───────────────────
  static String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'invalid-verification-code':
        return 'Invalid OTP code. Please check and try again.';
      case 'invalid-phone-number':
        return 'Invalid phone number format. Use +92XXXXXXXXXX';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}