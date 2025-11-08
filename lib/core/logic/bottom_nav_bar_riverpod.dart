import 'package:butcetakip/features/account/account_page.dart';
import 'package:butcetakip/features/assets/assets_page.dart';
import 'package:flutter/material.dart';
import '../../features/home/home_page.dart';
import '../../features/statistics/statistics_page.dart';
import '../enums/page_type_enum.dart';


class BottomNavBarRiverpod extends ChangeNotifier {

  PageType currentPage = PageType.home;

  void setCurrentPage(PageType page) {
    currentPage = page;
    notifyListeners();
  }

  void goToHome() {
    setCurrentPage(PageType.home);
  }

  void goToStatistics() {
    setCurrentPage(PageType.statistics);
  }

  void goToAssets() {
    setCurrentPage(PageType.assets);
  }

  void goToAccount() {
    setCurrentPage(PageType.account);
  }

  Widget body() {
    switch (currentPage) {
      case PageType.home:
        return const HomePage();
      case PageType.statistics:
        return const StatisticsPage();
      case PageType.assets:
        return const AssetsPage();
      case PageType.account:
        return const AccountPage();
    }
  }
}