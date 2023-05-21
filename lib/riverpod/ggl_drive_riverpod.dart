import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GglDriveRiverpod extends ChangeNotifier{
  bool? RfPageSt ;
  bool? accountStatus;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    setAccountStatus(true);
    refreshPage();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    setAccountStatus(false);
    refreshPage();
    print("Google ile çıkış yapıldı");
  }
  bool isUserLoggedIn() {
    final User? user = _auth.currentUser;
    return user != null;
  }

  bool checkAuthState() {
    print("kontrol geldi build oldu !");
    if (isUserLoggedIn()) {
      return true;
    } else {
      return false;
    }
  }


  String? getUserEmail(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email ;
    } else {
      print("hesap açılmamış!!");
    }
  }
  String? getUserDisplayName(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName;
    } else {
      print("hesap açılmamış!!");
    }
  }

  String? getUserName(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName ;
    } else {
      print("hesap açılmamış!!");
    }
  }
  void refreshPage(){
    RfPageSt != RfPageSt;
    notifyListeners();
  }
  void setAccountStatus(bool status) {
    print("değiştirdiiim = > ${status}") ;
    accountStatus = status ;
    notifyListeners();
  }
}
