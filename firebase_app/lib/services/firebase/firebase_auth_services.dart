
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthServices extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();
  final RxBool isAuthInitialized = false.obs;

  User? get user => _user.value;

  bool get isLoggedIn => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen((user) {
      isAuthInitialized.value = true;
    });
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
