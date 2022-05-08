import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:product_verification/views/home.dart';
import 'package:product_verification/views/loginsignup/login.dart';

// class AuthService {
//   final FirebaseAuth _auth;

//   AuthService(this._auth);

//   Stream<User?> get authStateChanges => _auth.idTokenChanges();

//   Future<String> login(String email, String password) async {
//     try {
//       _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Logged In";
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> signUp(String email, String password) async {
//     try {
//       _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return "Signed Up";
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isLoading = false.obs;

  late Rx<User?> _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("go to login page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void registerUser(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => null);
      return;
    } catch (e) {
      Get.snackbar("Account Creation Failed", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return;
    } catch (e) {
      Get.snackbar("Account Login Failed", e.toString());
    }
  }

  void logOut() async {
    try {
      await _auth.signOut();
      return;
    } catch (e) {
      Get.snackbar("Cannot LogOut", e.toString());
    }
  }
}
