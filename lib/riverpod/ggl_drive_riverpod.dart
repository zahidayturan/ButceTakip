import 'dart:io';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GglDriveRiverpod extends ChangeNotifier{
  bool? RfPageSt ;
  bool? accountStatus;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  Future<String?> uploadFileToStorage() async { //bu çalışıyor A planı
    //await writeToCvs();
        //Directory tempDir = await getApplicationDocumentsDirectory() ;
    var tempDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    final filePath = "${tempDir}/Bka_data.cvs";
    final File f = File(filePath) ;
    if (f.existsSync()) {
      Reference storageRef = _storage.ref().child("ButceTakipArchive/${_auth.currentUser?.email}/Bka_CSV.cvs");

      UploadTask uploadTask = storageRef.putFile(f);
      TaskSnapshot taskSnapshot = await uploadTask;

      uploadTask.snapshotEvents.listen((event) {
        switch (taskSnapshot.state) {
          case TaskState.running:
          // ...Veri aktarıldıkça düzenli olarak yayınlanır ve bir yükleme/indirme göstergesini doldurmak için kullanılabilir
            break;
          case TaskState.paused:
          // ...Görev her duraklatıldığında yayınlanır.
            break;
          case TaskState.success:
          // ...Görev başarıyla tamamlandığında yayınlanır.
            break;
          case TaskState.canceled:
          // ...Görev her iptal edildiğinde yayınlanır.
            break;
          case TaskState.error:
          // ...Yükleme başarısız olduğunda yayınlanır. Bu, ağ zaman aşımı, yetkilendirme hataları veya görevi iptal etmeniz durumunda olabilir.
            break;
        }
      });

      if (f.existsSync()) {
        f.deleteSync();
        print('Dosya silindi.');
      } else {
        print('Dosya bulunamadı.');
      }// Dosyayı silmek için await kullanın

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      print('Dosya bulunamadı ==> $filePath');
      return null;
    }
  }

  Future<void> downloadFileToDevice() async {
    //Directory tempDir = await getApplicationDocumentsDirectory() ;
    var tempDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    final String fileName = "Bka_data.cvs";
    final filePath = "$tempDir/$fileName";
    final f = File(filePath);
    Reference storageRef = _storage.ref().child("ButceTakipArchive/${_auth.currentUser?.email}/Bka_CSV.cvs");

    final downloadTask = storageRef.writeToFile(f);
    downloadTask.snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          break;
        case TaskState.paused:
          break;
        case TaskState.success:
          await restore();
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
      }
    });
  }

  Future <void> downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/${ref.name}");
    await ref.writeToFile(file);
  }
  Future<User?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    }

    final googleSignInAccount = await _googleSignIn.signIn();
    final googleSignInAuthentication = await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final currentUser = authResult.user;

    return currentUser;
  }


  Future <void> up() async { //Drive üzerinden dosya seçtiriyor.
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path.toString());
        final fileName = basename(file.path);
        final media = drive.Media(file.openRead(), file.lengthSync());
        print(file);
        final client = await _googleSignIn.signInSilently();
        final auth = await client!.authentication;
        /*
        final credentials = AccessCredentials(
            AccessToken(auth.accessToken!, auth.expiry),
            await refreshCredentials(
              ClientId(auth.clientId, auth.clientSecret),
              AccessCredrent.ExecutionException: com.google.firebase.internal.api.FirebaseNoSignedInUserException: Please sign in before trying to get a token.
W/ExponenentialBackoff(27442): network unavailable, sleeping.
E/StorageUtil(27442): error getting token java.util.concurrent.ExecutionException: com.google.firebase.internal.api.FirebaseNoSignedInUserException: Please sign in before trying to get a token.
W/ExponenentialBackoff(27442): network unavailable, sleeping.
E/StorageUtil(27442): error getting token java.util.concurrent.ExecutionException: com.google.firebase.internal.api.FirebaseNoSignedInUserException: Please sign in before trying to get a token.
W/ExponenentialBackoff(27442): network unavailable, sleeping.
E/StorageUtil(27442): error getting token java.util.concurrent.ExecutionException: com.google.firebase.internal.api.FirebaseNoSignedInUserException: Please sign in before trying to get a token.
W/ExponenentialBackoff(27442): network unavailable, sleeping.
E/StorageUtil(27442): error getting token java.util.centials(
                AccessToken(auth.accessToken, auth.expiry),
                auth.refreshToken,
                auth.scopes,
              ),
            ),
        );


        try {
          final uploadedFile = await _driveApi.files.create(
            driveFile,
            uploadMedia: media,
          );

          print('Dosya yüklendi: ${uploadedFile.name}');
        } catch (e) {
          print('Dosya yüklenirken hata oluştu: $e');
        }
         */
      }
  }

  Future<void> uploadFile() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', drive.DriveApi.driveFileScope]);

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    final file = File('/file.txt');
    final fileStream = file.openRead();
    final expiryDateTime = DateTime.now().add(Duration(hours: 1)).toUtc();
    /*
    final authClient = await clientViaUserConsent(
      ClientId('997825583670-v3hb69d5dba99l0uspgou76ndfgq67q0.apps.googleusercontent.com', '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'),
      ['https://www.googleapis.com/auth/drive.file'],
      userPromptUrl: Uri.parse('YOUR_REDIRECT_URI'),
      httpClient: client,
    );

     */
    //final driveClient = drive.DriveApi(authClient);
    final driveFile = drive.File();
    driveFile.name = basename(file.path);

    final uploadMedia = drive.Media(fileStream, file.lengthSync());

    //final driveResponse = await driveClient.files.create(driveFile, uploadMedia: uploadMedia);
    //final uploadedFile = driveResponse;

    //print('Dosya yüklendi: ${uploadedFile?.name}');
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
