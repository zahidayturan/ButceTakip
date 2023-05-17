import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;

class GoogleDriveHelper {
  static const _credentialsPath = 'credentials/google_drive_credentials.json';
  static const _scopes = [drive.DriveApi.driveScope];

  Future<drive.DriveApi> _getDriveClient() async {
    final credentials = await auth.clientViaServiceAccount(
      File(_credentialsPath).readAsStringSync() as auth.ServiceAccountCredentials,
      _scopes,
    );

    return drive.DriveApi(credentials);
  }

  Future<void> uploadFile(String filePath, String folderId) async {
    final driveApi = await _getDriveClient();
    final file = File(filePath);

    await driveApi.files.create(
      drive.File()..name = file.path.split('/').last,
      uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
      supportsAllDrives: true,

    );
  }

  Future<List<drive.File>?> listFilesInFolder(String folderId) async {
    final driveApi = await _getDriveClient();

    final fileList = await driveApi.files.list(
      q: "'$folderId' in parents",
    );

    return fileList.files;
  }
}
