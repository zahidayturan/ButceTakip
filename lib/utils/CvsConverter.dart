import 'dart:io';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dbHelper.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

Future <void> writeToCvs() async{

  final PermissionStatus permissionStatus = await Permission.storage.request();
  if (permissionStatus == PermissionStatus.granted) {
    final Database db = await SQLHelper.db();
    final List<Map<String, dynamic>> allData = await db.query("spendinfo", orderBy: "id") ;

    final List<List<dynamic>> rows = <List<dynamic>>[];
    File f = File('/storage/emulated/0/Download' + "/alldata.csv");
    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    print("dir $path");
    String file = "$path";

    for(final Map<String, dynamic> map in allData) {
      final List<dynamic> row = map.values.toList();
      print(row) ;
      rows.add(row);
    }

    final String cvs = ListToCsvConverter().convert(rows);
    await f.writeAsString(cvs);
    print("Yüklendi");
  } else {
    // İzin reddedildi, bir hata mesajı gösterin veya başka bir işlem yapın
  }

  //final String fileName = "alldata.cvs";
  final directory = await getExternalStorageDirectory() ;
  //final String filePath = '${directory?.path}/$fileName' ;

  //final File file = File(filePath);
  //await file.writeAsString(cvs);
}
Future<void> restore() async{
  final fileName = "alldata.cvs" ;
  final File file = File('/storage/emulated/0/Download' + "/alldata.csv");
  final List<List<dynamic>> csvData = CsvToListConverter().convert(await file.readAsString());
  final List<spendinfo> lastList = csvData.map((csvRow) => spendinfo.fromCVSObjetct(csvRow)).toList();
  for(var i =0 ; i < lastList.length  ;i++){
    print(lastList[i].operationType);
  }
}