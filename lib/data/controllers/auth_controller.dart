import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';

import '../model/user_model.dart';
import 'firestore_controller.dart';

class AuthenticationController extends GetxController {
  static const String isLogged = 'is_logged';

  final _firebaseAuth = FirebaseAuth.instance;
  final _fireService = Get.find<FirestoreController>();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  String currentUserId() => _firebaseAuth.currentUser?.uid ?? '';

  Future<FirebaseResult> isUserLoggedIn() async {
    try {
      var user = _firebaseAuth.currentUser;
      return FirebaseResult(data: user);
    } catch (e) {
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> populateCurrentUser() async {
    var result =
        await _fireService.getUser(_firebaseAuth.currentUser?.uid ?? '');

    if (!result.hasError) {
      _currentUser = result.data;
      return FirebaseResult(data: result);
    } else {
      return FirebaseResult(data: null);
    }
  }

  Future<FirebaseResult> createNewUserForEmail(String name) async {
    //create-user in firestore after sign up with firebase
    final firebaseUser = _firebaseAuth.currentUser;

    final user = UserModel(
        name: name,
        email: firebaseUser?.email ?? '',
        userId: firebaseUser?.uid ?? '',
        createdDate: Timestamp.now());

    var result = await _fireService.createUser(user);

    if (result is bool) {
      _currentUser = user;
      //assign user to base controller user variable to use across the app
      return FirebaseResult(data: true);
    } else {
      return FirebaseResult.error(errorMessage: 'text001'.tr);
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    Get.offAllNamed(AppRoutes.signIn);
  }
}

class FirebaseResult {
  final dynamic data;

  /// Contains the error message for the request
  final String errorMessage;

  FirebaseResult({this.data}) : errorMessage = '';

  FirebaseResult.error({required this.errorMessage}) : data = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage.isNotEmpty;
}
