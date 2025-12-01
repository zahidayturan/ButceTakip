import 'package:device_info_plus/device_info_plus.dart';

Future<int> getAndroidVersion() async {
  AndroidDeviceInfo androidInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    androidInfo = await deviceInfo.androidInfo;
    String androidVersion = androidInfo.version.release;
    print('Android Sürümü: $androidVersion');
    return int.parse(androidVersion);
  } catch (e) {
    print('Android sürümüne erişilemiyor: $e');
  }
  return 0;
}