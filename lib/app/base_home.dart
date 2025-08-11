import 'package:butcetakip/UI/app_status.dart';
import 'package:butcetakip/UI/introduction_page.dart';
import 'package:butcetakip/UI/my_assistant.dart';
import 'package:butcetakip/core/app_info.dart';
import 'package:butcetakip/core/widgets/nav_bar.dart';
import 'package:butcetakip/utils/notification_service.dart';
import 'package:butcetakip/utils/security_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Pages/more/password_splash.dart';
import '../riverpod_management.dart';
import '../utils/cvs_converter.dart';

class BaseHome extends ConsumerStatefulWidget {
  final bool showBTA;
  final Map<String, String>? appInfo;
  const BaseHome({super.key, required this.showBTA, required this.appInfo});

  @override
  ConsumerState<BaseHome> createState() => _BaseHomeState();
}

class _BaseHomeState extends ConsumerState<BaseHome> {
  Future<void> _backup(String fileName, WidgetRef ref) async {
    final gglDrive = ref.read(gglDriveRiverpod);
    final settings = ref.read(settingsRiverpod);

    if (settings.errorStatusBackup == "internet") {
      settings.setbackUpAlert(true);
      gglDrive.setAccountStatus(false);
    } else {
      await writeToCvs(fileName);
      try {
        await gglDrive.uploadFileToStorage();
        settings.setLastBackup();
      } catch (e) {
        print("Yedeklenme sırasında hata saptandı = $e");
        // Consider a more robust retry mechanism or error reporting
        try {
          await _backup(fileName, ref); // Recursive call, be careful with this
        } catch (b) {
          if (e.toString() == b.toString()) { // Compare error messages, might not be reliable
            settings.setbackUpAlert(true);
            return;
          } else {
            print("farklı hata: $b");
          }
        }
      }
    }
  }

  Future<void> _handlePasswordNavigation() async {
    final settings = ref.read(settingsRiverpod);
    if (settings.isPassword == 1 && settings.Password != "null") {
      print("Password var göster");
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (context, animation, nextanim) => PasswordSplash(),
          reverseTransitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (context, animation, nexttanim, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else if (settings.isPassword == null) {
      print("Password için emulator yavas kaldı.");
    }
  }

  Future<void> _setupInitialProviders() async {
    final settings = ref.read(settingsRiverpod);
    await settings.setMonthStarDayForHomePage(settings.monthStartDay!);
    await ref.read(databaseRiverpod).setMonthandYear(settings.monthIndex.toString(), settings.yearIndex.toString());
    ref.read(homeRiverpod).setStatus();
    await ref.read(calendarRiverpod).setMonthStartDay(settings.monthStartDay!);
  }

  Future<void> _handleCurrencyControl() async {
    final home = ref.read(homeRiverpod);
    final updateData = ref.read(updateDataRiverpod);
    await ref.read(currencyRiverpod).controlCurrency(ref).then((_) {
      updateData.customizeRepeatedOperation(ref).then((_) => home.setStatus());
      updateData.customizeInstallmentOperation(ref).then((_) => home.setStatus());
    });
  }

  Future<void> _handleAssistantNavigation() async {
    final settings = ref.read(settingsRiverpod);
    if (widget.showBTA && settings.isAssistant != "null" && settings.assistantLastShowDate != null) {
      List<String> tarih2 = settings.assistantLastShowDate!.split(" ")[0].split("-");
      if (DateTime.now().difference(DateTime(int.parse(tarih2[0]), int.parse(tarih2[1]), int.parse(tarih2[2]))).inDays >= 7) {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 1),
            pageBuilder: (context, animation, nextanim) => const myAssistant(),
            reverseTransitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder: (context, animation, nexttanim, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    } else if (settings.isAssistant == null) {
      print("asistan için emulator yavas kaldı.");
    }
  }

  Future<void> _handleBackupLogic() async {
    final settings = ref.read(settingsRiverpod);
    final gglDrive = ref.read(gglDriveRiverpod);
    const String fileName = "Bka_CSV.cvs";

    if (widget.appInfo!["appInfoString"] != securityFile().noBackup) {
      if (settings.isBackUp == 1) {
        print("Yedeklenme açık");
        await gglDrive.checkAuthState(ref);
        if (gglDrive.accountStatus == true) {
          if (settings.lastBackup == null) {
             print("İlk yedekleme yapılıyor.");
             await _backup(fileName, ref);
             return;
          }
          List<String> datesplit = settings.lastBackup!.split(".");
          bool needsBackup = false;
          if (settings.Backuptimes == "Günlük") {
            if (datesplit.length == 3 && int.tryParse(datesplit[0]) != DateTime.now().day) {
              needsBackup = true;
            }
          } else if (settings.Backuptimes == "Aylık") {
            if (datesplit.length == 3 && int.tryParse(datesplit[2]) == DateTime.now().year) {
              if (DateTime.now().month - (int.tryParse(datesplit[1]) ?? 0) >= 1) {
                needsBackup = true;
              }
            } else if (datesplit.length == 3 && int.tryParse(datesplit[2]) != DateTime.now().year) {
              needsBackup = true;
            }
          } else if (settings.Backuptimes == "Yıllık") {
            if (datesplit.length == 3 && int.tryParse(datesplit[2]) != DateTime.now().year) {
              needsBackup = true;
            }
          }

          if (needsBackup) {
            print("${settings.Backuptimes} yedekleme yapılıyor.");
            await _backup(fileName, ref);
          } else {
            print("Yedekleme periyoduna göre bugün yedekleme yapılmış veya gerekmiyor.");
          }
        } else {
          settings.setBackup(false);
          print("Yedeklenmesi gerekiyor ama Google hesabı açık değil.");
        }
      } else if (settings.isBackUp == 0) {
        print("Yedekleme kapalı");
      } else {
        print("isBackUp durumu belirsiz, emulator yavaş olabilir.");
      }
    }
  }

  Future<void> _loadData() async {
    final settings = ref.read(settingsRiverpod);
    await settings.controlSettings(context);

    await _handlePasswordNavigation();
    await _setupInitialProviders();
    await _handleCurrencyControl();
    await _handleAssistantNavigation();
    await _handleBackupLogic();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    FirebaseNotificationService().connectNotification(context);
  }

  int _compareVersions(String version1, String version2) {
    List<int> v1 = version1.split('.').map(int.parse).toList();
    List<int> v2 = version2.split('.').map(int.parse).toList();
    for (int i = 0; i < 3; i++) {
      if (v1[i] < v2[i]) {
        return -1;
      } else if (v1[i] > v2[i]) {
        return 1;
      }
    }
    return 0;
  }

  Widget _buildMainWidget() {
    final appInfoString = widget.appInfo!["appInfoString"];
    final security = securityFile();

    if (appInfoString == security.careCode) {
      return AppStatus(status: "care");
    } else if (appInfoString == security.updateCode) {
      String currentVersion = AppInfo.version;
      String newVersion = widget.appInfo!["version"]!;
      if (_compareVersions(currentVersion, newVersion) == -1) {
        return AppStatus(status: "update");
      }
    }
    if (widget.showBTA) {
      return ref.watch(bottomNavBarRiverpod).body();
    } else {
      return IntroductionPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = _buildMainWidget();
    bool showNavBar = widget.showBTA;

    final appInfoString = widget.appInfo!["appInfoString"];
    final security = securityFile();

    if (appInfoString == security.careCode ||
        (appInfoString == security.updateCode &&
         _compareVersions(AppInfo.version, widget.appInfo!["version"]!) == -1)
    ) {
      showNavBar = false;
    }


    return Scaffold(
      body: mainWidget,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: showNavBar ? NavBar() : null,
    );
  }
}