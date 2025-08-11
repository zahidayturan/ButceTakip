import 'package:butcetakip/Pages/calculator_page.dart';
import 'package:butcetakip/Pages/calendar_page.dart';
import 'package:butcetakip/Pages/more/more.dart';
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

  void goToCalendar() {
    setCurrentPage(PageType.calendar);
  }

  void goToCalculator() {
    setCurrentPage(PageType.calculator);
  }

  void goToMore() {
    setCurrentPage(PageType.more);
  }

  Widget body() {
    switch (currentPage) {
      case PageType.home:
        return const Home();
      case PageType.statistics:
        return const Statistics();
      case PageType.calendar:
        return const Calendar();
      case PageType.calculator:
        return const Calculator();
      case PageType.more:
        return More();
    }
  }
}