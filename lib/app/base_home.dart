import 'package:butcetakip/core/widgets/app_status.dart';
import 'package:butcetakip/features/introduction/introduction_page.dart';
import 'package:butcetakip/core/constants/app_info.dart';
import 'package:butcetakip/core/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/notification_service.dart';
import '../core/utils/security_file.dart';
import '../riverpod_management.dart';

class BaseHome extends ConsumerStatefulWidget {
  final bool showBTA;
  final Map<String, String>? appInfo;
  const BaseHome({super.key, required this.showBTA, required this.appInfo});

  @override
  ConsumerState<BaseHome> createState() => _BaseHomeState();
}

class _BaseHomeState extends ConsumerState<BaseHome> {

  Future<void> _loadData() async {

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
      String currentVersion = AppInfo.appVersion;
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
         _compareVersions(AppInfo.appVersion, widget.appInfo!["version"]!) == -1)
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