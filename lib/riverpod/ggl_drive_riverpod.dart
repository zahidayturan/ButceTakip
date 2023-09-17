import 'dart:io';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../riverpod_management.dart';

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;

  final http.Client _client = new http.Client();

  GoogleAuthClient(this._headers);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
      return _client.send(request..headers.addAll(_headers));
    }
}

class GglDriveRiverpod extends ChangeNotifier{
  bool? backUpAlert;
  bool? RfPageSt ;
  bool? accountStatus;
  bool isSignedIn = false;
  String ?folderID ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  drive.DriveApi ?_driveApi;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', drive.DriveApi.driveScope]);
/*
  Future<void> _initializeDrive(GoogleSignInAccount account) async {
    final authHeaders = await account.authHeaders;
    final client = GoogleAuthClient(authHeaders);
    _driveApi = drive.DriveApi(client);
  } //
 */
  Future<UserCredential> signInWithGoogle() async {
    //final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['email', drive.DriveApi.driveScope]).signIn();
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['profile', 'email']).signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    /*
    if(googleUser != null){
      setAccountStatus(true);
    }
     */
    refreshPage();
    return FirebaseAuth.instance.signInWithCredential(credential);
  }//+
  Future<String?> checkFolderID() async { // drive içerisinde BütçeTakip adlı dosya var mı kontrolu yapıyor.
    var fileList = await _driveApi!.files.list();
    if (fileList.files != null) {
      var A = await fileList.files?.where((element) => element.name == "BütçeTakip");
      if (A?.length == 0) {
         final folder = drive.File()
           ..name = 'BütçeTakip'
           ..mimeType = 'application/vnd.google-apps.folder';
         final createdFolder = await _driveApi!.files.create(folder);
         print('Folder created with ID: ${createdFolder.id}');
         return createdFolder.id ;
       }else{
         print("Dosya Zaten Var");
         return A!.first.id ;
       }
    } else {
      final folder = drive.File()
        ..name = 'BütçeTakip'
        ..mimeType = 'application/vnd.google-apps.folder';
      final createdFolder = await _driveApi!.files.create(folder);
      print('Folder created with ID: ${createdFolder.id}');
      return createdFolder.id ;
    }
  }//+
  Future <void> controlListCount({List ?items}) async {
    List a = items ?? await ListOfFolder();
    if(a.length > 30){
      for(int index = a.length -1 ; index >= 15 ; index--){
        await deleteFileWithId(a[index].id);
      }
      return ;
    }else{
      return ;
    }
  }

  Future<List> ListOfFolder() async { // klasör içindeki dosyaları listeliyor.
    drive.FileList fileList = await _driveApi!.files.list(q: "'$folderID' in parents");
    List listem = fileList.files!;
    List filteredFile = await listem.where((file) {
      return file.name!.toString().startsWith("BT_Data") && file.name!.toString().endsWith(".csv") && file.name.toString().length >= 20 ;
    }).toList();
    return filteredFile ;
  }//+
  Future<void> downloadGoogleDriveFile(String fileId, String fileName) async {

    Directory tempDir = await getTemporaryDirectory();
    final filePath = "${tempDir.path}/$fileName";

    try {
      final GoogleSignInAccount? googleSignInAccount = _googleSignIn.currentUser;
      if (googleSignInAccount != null) {
        final authentication = await googleSignInAccount.authentication;
        final response = await http.get(
          Uri.parse('https://www.googleapis.com/drive/v3/files/$fileId?alt=media'),
          headers: {
            'Authorization': 'Bearer ${authentication.accessToken}',
          },
        );

        if (response.statusCode == 200) {
          final saveFile = File(filePath); // Remove quotes around savePath
          print('Dosya indirildi => ${saveFile.path} ');
          await saveFile.writeAsBytes(response.bodyBytes).then((value) => restore(fileName));
        } else {
          print('Failed to download file. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> deleteFileWithId(String fileId) async {
    try{
      await _driveApi!.files.delete(fileId);
      print('File deleted successfully.');
    }catch(e) {
      print("silinirken hata meydana geldi $e");
    }
  }
  Future<void> uploadFileToDrive(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    final file = File("${tempDir.path}/$fileName");

    final driveFile = drive.File()
      ..name = file.uri.pathSegments.last
      ..parents = [folderID!];

    if(_driveApi != null) {
      await _driveApi!.files.create(
        driveFile,
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      );
      print('File uploaded to user\'s Google Drive.');
    }else{
      print("ilk değer atnamadı :/");
    }
  }//+
  Future<String?> uploadFileToStorage() async {
    //bu çalışıyor A planı
    //var tempDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    Directory tempDir = await getTemporaryDirectory();
    final filePath = "${tempDir.path}/Bka_CSV.cvs";
    final File f = File(filePath) ;
    //googleDrive().uploadFileToDrive(filePath);
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
  }//-
  Future<void> downloadFileToDevice() async {
    //var tempDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    Directory tempDir = await getTemporaryDirectory();
    const String fileName = "Bka_CSV.cvs";
    final filePath = "${tempDir.path}/$fileName";
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
          await restore("Bka_CSV.cvs");
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
      }
    });
  }//-
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
  Future<void> signOutWithGoogle() async { // Hesaplardan  Çıkış yapıyor.
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    setAccountStatus(false);
    refreshPage();
    print("Google ile çıkış yapıldı");
  } //+
  bool isUserLoggedIn() { // giriş var mı kontrolu iriş varsa true değilse false dönüyor.
    final User? user = _auth.currentUser;
    return user != null;
  }
  Future<void> checkAuthState(WidgetRef ref) async { // Base_BKA tarafından çalıştırılan bir dosyadır. giriş durumunu atar.
    var readSettings = ref.read(settingsRiverpod);
    if(_auth.currentUser != null)  {
      try{
        accountStatus = true;
        /*
        await _googleSignIn.signInSilently().then((value) async {
          await _initializeDrive(_googleSignIn.currentUser!).then((value) => print("Kullanıcı initalize oldu."));
          await checkFolderID().then((value) {
            folderID = value;
            print("dosya konumu bulundu.");
          });
        });
         */
      }catch(e){
        print("INTERNET NOT FOUND FOR USER $e"); ///internetin yokluğu veya oturum süresi dolmasında buraya geliyor.
        readSettings.setErrorStatusBackup("internet");
      }
    }else{
      setAccountStatus(false);
    }
  }
  String? getUserPhotoUrl(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.photoURL;
    } else {
      print("hesap açılmamış!!");
      return null;
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
  void setBackupAlert(bool status) {
    backUpAlert = status ;
    notifyListeners();
  }
  String? getUserName(){
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName ;
    } else {
      print("hesap açılmamış!!");
    }
  }
  void refreshPage(){ //sayfayı yenilitiyoruz.
    RfPageSt != RfPageSt;
    notifyListeners();
  }
  void setAccountStatus(bool status) {
    print("Hesap Durumu Güncellendi. = > ${status}") ;
    accountStatus = status ;
  }
}
