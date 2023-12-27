import 'package:firebase_auth/firebase_auth.dart';

class ResponseModel {
  final String? error;
  final User? data;

  bool get isError => error != null;

  ResponseModel({
    this.error,
    this.data,
  });

  @override
  String toString() {
    if (error != null) return error!;
    return data.toString();
  }
}
