import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_auth_flow/models/response.dart';
import 'package:starlight_utils/starlight_utils.dart';

class AuthService {
  final FirebaseAuth _auth;

  ///latest
  User? currentUser;

  StreamSubscription? _userSubscription;

  final StreamController<User?> _authStateController =
      StreamController.broadcast();

  Stream<User?> get authState => _authStateController.stream;

  AuthService() : _auth = FirebaseAuth.instance {
    _userSubscription = _auth.userChanges().listen((user) {
      print("AuthState: $user");
      _authStateController.sink.add(user);
      currentUser = user;
    });
  }

  void dispose() {
    _userSubscription?.cancel();
    _authStateController.close();
  }

  ResponseModel? _isValid(String email, String password) {
    if (!email.isEmail) {
      return ResponseModel(error: "Email is not valid");
    }
    final result = password.isStrongPassword();
    if (result != null) {
      return ResponseModel(error: result);
    }
    return null;
  }

  Future<ResponseModel> _try(Future<ResponseModel> Function() callback) async {
    try {
      final result = await callback();
      return result;
    } on FirebaseAuthException catch (e) {
      return ResponseModel(error: e.message);
    } catch (e) {
      return ResponseModel(error: "Unknown error occur");
    }
  }

  Future<ResponseModel> register(String email, String password) async {
    return _try(() async {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return ResponseModel(data: credential.user);
    });
  }

  Future<ResponseModel> login(String email, String password) async {
    return _try(() async {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return ResponseModel(data: credential.user);
    });
  }

  Future<ResponseModel> signOut() async {
    return _try(() async {
      await _auth.signOut();
      return ResponseModel();
    });
  }

  Future<ResponseModel> sendResetLink(String email) async {
    return _try(() async {
      await _auth.sendPasswordResetEmail(email: email);
      return ResponseModel();
    });
  }
}
