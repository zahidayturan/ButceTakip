/*
Bu kod Gooogle drive yedekleme için kullanılacaktır şu anlık kullanuıma sunulmayacak.
 */
import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;
class googleDrive {

  var _clientId = "997825583670-vvjbts5lcama4e3819fcsjo0bdmovmth.apps.googleusercontent.com";
  var _scopes = ['https://www.googleapis.com/auth/drive.file'];
  var _clientSecret = "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";

  Future<void> uploadFileToDrive(File file) async {
    final credentials = ServiceAccountCredentials.fromJson(
        {
          "type": "service_account",
          "project_id": "butce-takip-44f8f",
          "private_key_id": "e209e83bcc1bad94500cb435e822a62362905701",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCJfHwlyeZZsRbJ\nHZ3kp3Q+kMxs+DCQsAinL3smBPLxudgvs4BW7A9TQInww0keaFrJgaUlNHh2aiOX\noro1B615bmx3y6Dj+GhwVQxzQVoxUr57wDdxkCRTAvDS7TSI0ULfmQxp3OUqBkRD\nxvaXQnnOENEYo1oi4zwTTRaBaPR3oEpz0eSLHgHGd+HshzalLY1PKoWzByVyxpbO\nTgQ37lszgMxCAYz/LC1XtFeSAl75g/qfc+0oevGC29pVW38p+ppaZL1gzzVrycdy\naAHpYr3BXMI5a+sFLOltf/UZ/ZMiVtTxMii3UZLUJMNnSP5iRD+z7NN3nnQoH40n\n3pR3p1TtAgMBAAECggEADGUlOjDwLBDrqXkalZVFRSi/zWk406qTNSNyOlTC5Gkp\nZO+NeAizPwG4DfVFP9EPslAWZ/rJi395MwAQQpytFqAOdmRs3nC0VcBNLYzsSTsZ\nAkYrmXjx1WwT8yhAjr8zBL6jIF4yaO4EtImZDL0JBzt75nk/tJqA/Yp7J3Kja69t\ngO6rE3PjY+W2JH1nOvgdwzJzR/tu8joCGaqfbhRr5zQMfT0sJQRcT8Ky4PYfcWQ/\nTVHQmgrtvKfT8+7fP9JshYVHBSyhiRkwg+gbeRmuX+O2bvut1/leVjjp88q65tuY\npKfyfd6DoLALFc6723jw+4M88Cgg4JJROLWvne6UYQKBgQC/te0/rFLQY4I+Cc5a\nxqgm9g6oXpELU9b0O/zihI/+u4Jpl6JB/tN4kWhq37k/HGOwOp3+cL94nPseBlGf\n1Ai2HMq9nhy0thoTMHkMxZJ9RrKlgMej1aYE8VqiNiQjSGc6ztYGY4Y/O45sP3Ph\nh5t0bshO2GJuvm/aeWOCwnxxXQKBgQC3l3nXcyX4fDyWSzREd5TxvY3hr/AX7QZe\nJmZ85WWCzt4C8VtxHwszalVtzh+Zaw75EMD3Jqu7d4UojQw0RUy2bJ7Zl1d2eXkg\n2oFuXGoAEeUhvR8IOWsE/4wGGt4Fb3V71mGhWX3V6oidkbBtzW56L1FXpxhyp3wE\ncHCc9PVo0QKBgQC5hJf+Eghh2Knk1yB1/+AhM+OjU0ARMiTFXHevzJB79YCSJkbC\njpKeDjh5k950EEj39QGHhBwF4AOyXnMGs+1qLhqTvDoTNlWtVC8QCPFlgdDHEAQh\nq1JpXhZS+wmlix86bYX30L/M2RlN72l4Sf5JghsdEZDPkkIzrVx64TIDkQKBgA7h\neD6+VpWNfFuyPMpP5wKxGo7wc8V8sMdw1V3KOjAgFF6osYC5w26nb8U2r9j/lHcb\npIhj2geX6HMg+5xBAbbHlxiL68rujaLcEyGe2/ileq0BZ0KDZOlCzVaxVs2Z+yvO\ndJtfZZOxLuGWrXY48Ht22mEAajrg2GyDsJ0IPdwBAoGBALVkOo4Q7F+jEmexY/kV\nQYGYozkWs5WNznhnju84TEcz57qqnxzznAXR+evvbSDBecwTHFFNnezMWn6CHuZi\nCen3lR82bteoroS231iDg3W5lajbRWYNZAS5EEIE8To3eaMcgY1YumOe0jQzz273\nn9p56r/DOK4d+DiKv4aa0T1I\n-----END PRIVATE KEY-----\n",
          "client_email": "butcetakip@butce-takip-44f8f.iam.gserviceaccount.com",
          "client_id": "111242848889956080660",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/butcetakip%40butce-takip-44f8f.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
    );

    final client = await clientViaUserConsent(
        ClientId(_clientId), _scopes, (url) {
        launch(url);
    });

    final driveApi = drive.DriveApi(client);

    final media = drive.Media(file.openRead(), file.lengthSync());

    final driveFile = drive.File()
      ..name = p.basename(file.absolute.path); // Dosya adını belirtin

    await driveApi.files.create(driveFile, uploadMedia: media);


  }
  Future<http.Client> getHttpClient() async {
    var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret), _scopes, (url) {
      launch(url);
    });
    return authClient;
  }

  Future upload(File file) async {
    var client = http.Client();
    final driveApi = drive.DriveApi(client);

    var response = await driveApi.files.create(
        drive.File()
          ..name = p.basename(file.absolute.path),
        uploadMedia: drive.Media(file.openRead(), file.lengthSync()));
    print(response.toJson());
  }

/*

import 'dart:io';
import 'package:butcekontrol/utils/cvs_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
class SecureStorage {
  final storage = FlutterSecureStorage();

  //Save Credentials
  Future saveCredentials(AccessToken token, String refreshToken) async {
    print(token.expiry.toIso8601String());
    await storage.write(key: "type", value: token.type);
    await storage.write(key: "data", value: token.data);
    await storage.write(key: "expiry", value: token.expiry.toString());
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  //Get Saved Credentials
  Future<Map<String, dynamic>?> getCredentials() async {
    var result = await storage.readAll();
    if (result.isEmpty) return null;
    return result;
  }

  //Clear Saved Credentials
  Future clear() {
    return storage.deleteAll();
  }
}
const _clientId = "997825583670-v3hb69d5dba99l0uspgou76ndfgq67q0.apps.googleusercontent.com";
const _scopes = ['https://www.googleapis.com/auth/drive.file'];
class DriveSign {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}

 */
/*
class GoogleDrive {
  final storage = SecureStorage();
  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      //Needs user authentication
      var authClient = await clientViaUserConsent(
          ClientId(_clientId),_scopes, (url) {
        //Open Url in Browser
        launch(url);
      });
      //Save Credentials
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken!);
      return authClient;
    } else {
      print(credentials["expiry"]);
      //Already authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credentials["type"], credentials["data"],
                  DateTime.tryParse(credentials["expiry"])!),
              credentials["refreshToken"],
              _scopes));
    }
  }

  // check if the directory forlder is already available in drive , if available return its id
  // if not available create a folder in drive and return id
  //   if not able to create id then it means user authetication has failed
  Future<String?> _getFolderId(ga.DriveApi driveApi) async {
    final mimeType = "application/vnd.google-apps.folder";
    String folderName = "personalDiaryBackup";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        print("Sign-in first Error");
        return null;
      }

      // The folder already exists
      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      ga.File folder = ga.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print("Hata =========>>>> $e");
      return null;
    }
  }


  uploadFileToGoogleDrive() async {
    Directory tempDir = await getTemporaryDirectory();
    final filePath = "${tempDir.path}/Bka_data.cvs";
    File file = File(filePath);
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    String? folderId =  await _getFolderId(drive);
    if(folderId == null){
      print("Sign-in first Error");
    }else {
      ga.File fileToUpload = ga.File();
      fileToUpload.parents = [folderId];
      fileToUpload.name = p.basename(file.absolute.path);
      var response = await drive.files.create(
        fileToUpload,
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
      );
      print(response);
    }

  }
/*
  Future<void> _downloadGoogleDriveFile(String fName, String gdID) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    Object file = await drive.files.get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
    print(file.stream);

    final directory = await getExternalStorageDirectory();
    print(directory);
    final saveFile = File('$directory/${DateTime.now().millisecondsSinceEpoch}$fName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      print("Task Done");
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error");
    });
  }


}
 */

 */


}