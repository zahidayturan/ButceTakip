import 'dart:io';
import 'package:butcekontrol/models/spend_info.dart';
import 'package:butcekontrol/utils/android_ino.dart';
import 'package:butcekontrol/utils/db_helper.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';

//Yedekleme Not Db güncellenmesi sonrasında verilerin işlenebilmesi için
//spendinfo dosyası   factory SpendInfo.fromCVSObjetct(List<dynamic> o ) fonksiyonu
///güncellendi.
Future <void> writeToCvs(String fileName) async {
  PermissionStatus ?permissionStatus;
  bool avalibility = false ;
  var verisonAn = await getAndroidVersion();
  if(verisonAn >= 10 ){
    avalibility = true;
  }else{
    permissionStatus = await Permission.storage.request();
    print("10 ve altı Sürüm geldii YIUPİİİ");
  }
  if (permissionStatus == PermissionStatus.granted || avalibility) {
    Directory tempDir = await getTemporaryDirectory(); //uygulamanın kendi deplaması
    final directory = "${tempDir.path}/$fileName";
    final File f = File(directory);
    /*
    if (f.existsSync()) {
      f.deleteSync();
      print('Dosya silindi.');
    } else {
      print('Dosya bulunamadı.');
    }// Dosyayı silmek için await
     */
    final Database db = await SQLHelper.db();
    //final List<Map<String, dynamic>> allData = await db.query("spendinfo", orderBy: "id", );
    final List<Map<String, dynamic>> allData = await db.rawQuery("SELECT id, operationType, category, operationTool, registration, amount, note, operationDay, operationMonth, operationYear, operationTime, operationDate, moneyType , processOnce, realAmount, userCategory, systemMessage FROM spendinfo");
    final List<List<dynamic>> rows = <List<dynamic>>[];
    //var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    print("dir $tempDir");

    for (final Map<String, dynamic> map in allData) {
      final List<dynamic> row = map.values.toList();
      print(row);
      rows.add(row);
    }
    DateTime date = DateTime.now();
    final String cvs = ListToCsvConverter().convert(rows);
    f.writeAsString(cvs);
    print("Dosya yazıldı.");
  } else {
    print("Erişim reddediliyor.");
    // İzin reddedildi, bir hata mesajı gösterin veya başka bir işlem yapın
  }
}
Future<void> restore(String fileName) async{
  PermissionStatus ?permissionStatus;
  bool avalibility = false ;
  var verisonAn = await getAndroidVersion();
  if(verisonAn >= 10 ){
     avalibility = true;
  }else{
    print("10 ve altı Sürüm geldii YIUPİİİ");
    permissionStatus = await Permission.storage.request();
  }
  if (permissionStatus == PermissionStatus.granted || avalibility) {
    final Database db = await SQLHelper.db();
    await db.delete("spendinfo");
    //var tempDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    Directory tempDir = await getTemporaryDirectory();
    //Directory tempDir = await getApplicationDocumentsDirectory() ;
    final directory = "${tempDir.path}/$fileName";
    final File f = File(directory);
    final List<List<dynamic>> csvData = const CsvToListConverter().convert(await f.readAsString());
    List lastList = csvData.map((csvRow) => SpendInfo.fromCVSObjetct(csvRow)).toList();

    for (var i = 0; i < lastList.length; i++) {
      await SQLHelper.createItem(lastList[i]);
      print(lastList[i].toMap());
    }
    if (f.existsSync()) {
      f.deleteSync();
      print('Dosya silindi.');
    } else {
      print('Dosya bulunamadı.');
    }// Dosyayı silmek için await kullan
  }else{
        print("Erişim reddediliyor.");
    }
}

