import 'package:flutter/cupertino.dart';
import '../classes/language.dart';

class Converter{
  String textConverterToDB(String text, BuildContext context, int operetionType)
  {
    /// DataBase'e gönderilecek olan kategorilerin çevrilmesi için
    if(operetionType == 0) {
      if (text == translation(context).foodExpense) {
        return "Yemek";
      } else if (text == translation(context).clothingExpense) {
        return "Giyim";
      } else if (text == translation(context).entertainmentExpense) {
        return "Eğlence";
      } else if (text == translation(context).educationExpense) {
        return "Eğitim";
      } else if (text == translation(context).duesRentExpense) {
        return "Aidat/Kira";
      } else if (text == translation(context).shoppingExpense) {
        return "Alışveriş";
      } else if (text == translation(context).personelExpense) {
        return "Özel-";
      } else if (text == translation(context).transportExpense) {
        return "Ulaşım";
      } else if (text == translation(context).healthExpense) {
        return "Sağlık";
      } else if (text == translation(context).dailyExpenses) {
        return "Günlük Yaşam";
      } else if (text == translation(context).hobbyExpense) {
        return "Hobi";
      } else if (text == translation(context).otherExpense) {
        return "Diğer-";
      }
      else if (text == translation(context).pocketMoneyIncome) {
        return "Harçlık";
      } else if (text == translation(context).grantIncome) {
        return "Burs";
      } else if (text == translation(context).salaryIncome) {
        return "Maaş";
      } else if (text == translation(context).creditIncome) {
        return "Kredi";
      } else if (text == translation(context).personalIncome) {
        return "Özel+";
      } else if (text == translation(context).duesRentIncome) {
        return "Kira/Aidat";
      } else if (text == translation(context).overtimeIncome) {
        return "Fazla Mesai";
      } else if (text == translation(context).freelanceIncome) {
        return "İş Getirisi";
      } else if (text == translation(context).incomeViaCurrencyIncome) {
        return "Döviz Getirisi";
      } else if (text == translation(context).investmentIncome) {
        return "Yatırım Getirisi";
      } else if (text == translation(context).otherIncome) {
        return "Diğer+";
      } else {
        return text;
      }
    }
    else if(operetionType == 1) {
      if (text == translation(context).dailyAddData) {
        return "Günlük";
      } else if (text == translation(context).weeklyAddData) {
        return "Haftalık";
      } else if (text == translation(context).biweekly) {
        return "İki Haftada Bir";
      } else if (text == translation(context).monthlyAddData) {
        return "Aylık";
      } else if (text == translation(context).bimonthly) {
        return "İki Ayda Bir";
      } else if (text == translation(context).everyThreeMonths) {
        return "Üç Ayda Bir";
      } else if (text == translation(context).everyFourMonths) {
        return "Dört Ayda Bir";
      } else if (text == translation(context).everySixMonths) {
        return "Altı Ayda Bir";
      } else if (text == translation(context).yearlyAddData) {
        return "Yıllık";
      } else {
        return text;
      }
    }
    else{
      return "";
    }
  }

  String textConverterFromDB(String text, BuildContext context, int operetionType){
    /// Kategori çevirmesi
    if(operetionType == 0){
      if (text == "Yemek") {
        return translation(context).foodExpense;
      } else if (text == "Giyim") {
        return translation(context).clothingExpense;
      } else if (text == "Eğlence") {
        return translation(context).entertainmentExpense;
      } else if (text == "Eğitim") {
        return translation(context).educationExpense;
      } else if (text == "Aidat/Kira") {
        return translation(context).duesRentExpense;
      } else if (text == "Alışveriş") {
        return translation(context).shoppingExpense;
      } else if (text == "Özel-") {
        return translation(context).personelExpense;
      } else if (text == "Ulaşım") {
        return translation(context).transportExpense;
      } else if (text == "Sağlık") {
        return translation(context).healthExpense;
      } else if (text == "Günlük Yaşam") {
        return translation(context).dailyExpenses;
      } else if (text == "Hobi") {
        return translation(context).hobbyExpense;
      } else if (text == "Diğer-") {
        return translation(context).otherExpense;
      }
      else if (text == "Harçlık") {
        return translation(context).pocketMoneyIncome;
      } else if (text == "Burs") {
        return translation(context).grantIncome;
      } else if (text == "Maaş") {
        return translation(context).salaryIncome;
      } else if (text == "Kredi") {
        return translation(context).creditIncome;
      } else if (text == "Özel+") {
        return translation(context).personalIncome;
      } else if (text == "Kira/Aidat") {
        return translation(context).duesRentIncome;
      } else if (text == "Fazla Mesai") {
        return translation(context).overtimeIncome;
      } else if (text == "İş Getirisi") {
        return translation(context).freelanceIncome;
      } else if (text == "Döviz Getirisi") {
        return translation(context).incomeViaCurrencyIncome;
      } else if (text == "Yatırım Getirisi") {
        return translation(context).investmentIncome;
      } else if (text == "Diğer+") {
        return translation(context).otherIncome;
      } else {
        return text;
      }
    }
    else if(operetionType == 1) {
      if (text == "Günlük") {
        return translation(context).dailyAddData;
      } else if (text == "Haftalık") {
        return translation(context).weeklyAddData;
      } else if (text == "İki Haftada Bir") {
        return translation(context).biweekly;
      } else if (text == "Aylık") {
        return translation(context).monthlyAddData;
      } else if (text == "İki Ayda Bir") {
        return translation(context).bimonthly;
      } else if (text == "Üç Ayda Bir") {
        return translation(context).everyThreeMonths;
      } else if (text == "Dört Ayda Bir") {
        return translation(context).everyFourMonths;
      } else if (text == "Altı Ayda Bir") {
        return translation(context).everySixMonths;
      } else if (text == "Yıllık") {
        return translation(context).yearlyAddData;
      } else {
        return text;
      }
    }
    else{
      return "";
    }
  }

}
