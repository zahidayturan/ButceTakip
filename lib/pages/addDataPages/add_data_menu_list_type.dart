import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/pages/addDataPages/add_customize.dart';
import 'package:butcekontrol/pages/addDataPages/select_category.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart' as intl;

class AddDataMenuListType extends ConsumerStatefulWidget {
  late int addDataMode;
  AddDataMenuListType({Key? key,required this.addDataMode}) : super(key: key);
  @override
  ConsumerState<AddDataMenuListType> createState() => _AddDataMenuListType();
}

class _AddDataMenuListType extends ConsumerState<AddDataMenuListType> {

  @override
  void dispose() {
    var readAdd = ref.read(addDataRiverpod);
    readAdd.category.dispose();
    readAdd.customize.dispose();
    readAdd.note.dispose();
    readAdd.amount.dispose();
    readAdd.operationType.dispose();
    readAdd.operationTool.dispose();
    readAdd.registration.dispose();
    readAdd.operationDate.dispose();
    readAdd.moneyType.dispose();
    super.dispose();
  }
  CustomColors renkler = CustomColors();
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
        child: SizedBox(
          height: size.height * 0.74,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: size.width * 0.99,
                  child: Text(
                      'DEBUG: Type: ${readAdd.operationType.text} - Reg: ${int.parse(readAdd.registration.text)} - RegController: ${readAdd.regsController} - Category: ${readAdd.category.text} - ConvertedCategory ${readAdd.convertedCategory} - UserCategory: ${readAdd.userCategoryController} - Tool: ${readAdd.operationTool.text} - Amount: ${readAdd.amount.text} - Not: ${readAdd.note.text} - Date: ${readAdd.operationDate.text} -${readAdd.customize.text} - ${readAdd.convertedCustomize} - ${readAdd.selectedCustomizeMenu} - ${readAdd.moneyType.text}',
                      style: const TextStyle(
                          color: Colors.red,fontSize: 11, fontFamily: 'TL'))),
              SizedBox(height: 8,),
              getRow("Türü", typeCustomButton(context)),
              SizedBox(height: 16,),
              getRow("Tarihi", dateCustomButton(context)),
              SizedBox(height: 16,),
              getRow("Saati", timeCustomButton(context)),
              SizedBox(height: 16,),
              getRow("Ödeme\nAracı", toolCustomButton(context)),
              SizedBox(height: 16,),
              getRow("Kategorisi", categoryBarCustom(context)),
              SizedBox(height: 16,),
              getRow("Notu", noteCustomButton(context)),
              SizedBox(height: 16,),
              getRow("İşlemi Kaydet", regCustomButton(context)),
              SizedBox(height: 16,),
              getRow("Özelleştir", customizeBarCustom(context)),
              SizedBox(height: 16,),
              getRow("Tutarı", amountCustomButton())
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(String text,Widget widget){
    Color textColor = Theme.of(context).canvasColor;
    double size = 16.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getLineText(text, textColor, size),
        widget
      ],
    );
  }

  Widget getLineText(String text,Color textColor,double size,{String? fontFamily,FontWeight? weight , Color? backgroundColor}){
    return Text(
      text,style: TextStyle(
        color: textColor,
        height: 1,
        fontFamily: fontFamily ?? "Nexa3",
        fontSize: size,
        fontWeight: weight ?? FontWeight.normal,
        backgroundColor: backgroundColor
    ),
    );
  }

  Widget getDecoratedBox(double width,double height,BorderRadiusGeometry radius,{Color? boxColor,Widget? child,EdgeInsetsGeometry? padding,BoxBorder? border}){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: radius,
              color: boxColor,
              border: border
          ),
          child: child,
        ),
      ),
    );
  }

  Widget typeCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      height: 30,
      child: getToggleSwitch(readAdd.initialLabelIndexForType, 2, [translation(context).expenses, translation(context).income], size.width > 392 ? size.width * 0.235 : 92,mode: "Type", (index) {
        setState(() {
          if (index == 0) {
            readAdd.operationType.text = "Gider";
            readAdd.selectedCategory = 0;
            readAdd.category.clear();
            readAdd.selectedValue = null;
          } else {
            readAdd.operationType.text = "Gelir";
            readAdd.selectedCategory = 1;
            readAdd.category.clear();
            readAdd.selectedValue = null;
          }
          readAdd.categoryColorChanger = 999;
        });
        readAdd.initialLabelIndexForType = index!;
      }),
    );
  }

  Widget getToggleSwitch(int? initialLabel, int totalSwitch,List<String>? labels,double minWidth,Function(int?)? onToggle,{String? mode}){
    List<Color> activeColor(){
      if(mode == "Type"){
        if(ref.read(addDataRiverpod).operationType.text == "Gelir"){
          return [renkler.yesilRenk];
        }else{
          return [renkler.kirmiziRenk];
        }
      }else{
        return [Theme.of(context).highlightColor];
      }

    }

    return ToggleSwitch(
      initialLabelIndex: initialLabel,
      totalSwitches: totalSwitch,
      dividerColor: Theme.of(context).highlightColor,
      labels: labels,
      activeBgColor: activeColor(),
      activeFgColor: renkler.yaziRenk,
      inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
      inactiveFgColor: Theme.of(context).canvasColor,
      borderColor: [Theme.of(context).highlightColor],
      borderWidth: 1,
      minWidth: minWidth,
      cornerRadius: 10,
      radiusStyle: true,
      animate: true,
      curve: Curves.linearToEaseOut,
      customTextStyles: const [
        TextStyle(
            fontSize: 13,
            fontFamily: 'Nexa4',
            height: 1,
            fontWeight: FontWeight.w800)
      ],
      onToggle: onToggle,
    );
  }

  Widget dateCustomButton(BuildContext context) {
    var readAdd = ref.read(addDataRiverpod);
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: readAdd.selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        keyboardType: TextInputType.number,
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                  shadowColor: Colors.black54,
                  backgroundColor: Theme.of(context).indicatorColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
                    foregroundColor: Theme.of(context).canvasColor,
                    textStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15)// button text color
                ),
              ),
              dividerTheme: DividerThemeData(
                  color: Theme.of(context).canvasColor,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5
              ),
              datePickerTheme: DatePickerThemeData(
                dayStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15),
                todayForegroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                dayOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                headerForegroundColor: renkler.yaziRenk,
                weekdayStyle: TextStyle(fontFamily: "Nexa4",height: 1,fontSize: 15,color: Theme.of(context).secondaryHeaderColor),
                yearForegroundColor: MaterialStatePropertyAll(Theme.of(context).canvasColor),
                yearOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                yearBackgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                headerBackgroundColor: renkler.koyuuRenk,
              ),
              textTheme: TextTheme(
                labelSmall: const TextStyle(
                  ///tarih seçiniz
                    fontSize: 16,
                    fontFamily: 'Nexa4'),
                titleSmall: TextStyle(
                  ///ay ve yıl
                    fontSize: 16,
                    fontFamily: 'Nexa3',
                    color: renkler.koyuuRenk),
                headlineMedium: TextStyle(
                  ///gün ay gün
                    fontSize: 26,
                    fontFamily: 'Nexa3',
                    color: renkler.koyuuRenk),
                bodyLarge: TextStyle(
                  ///alt YILLAR
                    fontSize: 16,
                    fontFamily: 'Nexa3',
                    color: Theme.of(context).disabledColor),
              ),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: renkler.koyuuRenk, // üst taraf arkaplan rengi
                onPrimary: renkler.arkaRenk, //üst taraf yazı rengi
                secondary: renkler.kirmiziRenk,
                onSecondary: renkler.arkaRenk,
                primaryContainer: renkler.kirmiziRenk,
                error: const Color(0xFFD91A2A),
                onError: const Color(0xFFD91A2A),
                background: renkler.kirmiziRenk,
                onBackground: renkler.yesilRenk,
                surface: Theme.of(context).disabledColor, //ÜST TARAF RENK
                onPrimaryContainer: renkler.yesilRenk,
                onSurface: Theme.of(context).canvasColor, //alt günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          readAdd.selectedDate = picked;
          readAdd.operationDate.text =
              intl.DateFormat('dd.MM.yyyy').format(readAdd.selectedDate!);
        });
      }
    }
    var readSettings = ref.read(settingsRiverpod);

    String getFormattedDate(String date){
      List <String> parts = date.split(".");
      int parseDay = int.parse(parts[0]);
      int parseMonth = int.parse(parts[1]);
      int parseYear = int.parse(parts[2]);
      String formattedDate = readSettings.dateFormat == "yyyy.MM.dd" ? "$parseYear.$parseMonth.$parseDay" : readSettings.dateFormat == "MM.dd.yyyy" ? "$parseMonth.$parseDay.$parseYear" : "$parseDay.$parseMonth.$parseYear";
      return formattedDate;
    }

    return SizedBox(
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color: Theme.of(context).highlightColor,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1,right: 10,left: 10),
          child: InkWell(
            onTap: () {
              selectDate(context);
            },
            child: Center(
                child: getLineText(getFormattedDate(readAdd.operationDate.text), Theme.of(context).canvasColor, 13,fontFamily: "Nexa4")),
          ),
        ),
      ),
    );
  }

  Widget timeCustomButton(BuildContext context) {
    var readAdd = ref.read(addDataRiverpod);
    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 12, minute: 30),
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                  shadowColor: Colors.black54,
                  backgroundColor: Theme.of(context).indicatorColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10))),
                    foregroundColor: Theme.of(context).canvasColor,
                    textStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15)// button text color
                ),
              ),
              dividerTheme: DividerThemeData(
                  color: Theme.of(context).canvasColor,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5
              ),
              datePickerTheme: DatePickerThemeData(
                dayStyle: const TextStyle(fontFamily: "Nexa3",height: 1,fontSize: 15),
                todayForegroundColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                dayOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                headerForegroundColor: renkler.yaziRenk,
                weekdayStyle: TextStyle(fontFamily: "Nexa4",height: 1,fontSize: 15,color: Theme.of(context).secondaryHeaderColor),
                yearForegroundColor: MaterialStatePropertyAll(Theme.of(context).canvasColor),
                yearOverlayColor: MaterialStatePropertyAll(Theme.of(context).disabledColor),
                yearBackgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                headerBackgroundColor: renkler.koyuuRenk,
              ),
              textTheme: TextTheme(
                labelSmall: const TextStyle(
                  ///tarih seçiniz
                    fontSize: 16,
                    fontFamily: 'Nexa4'),
                titleSmall: TextStyle(
                  ///ay ve yıl
                    fontSize: 16,
                    fontFamily: 'Nexa3',
                    color: renkler.koyuuRenk),
                headlineMedium: TextStyle(
                  ///gün ay gün
                    fontSize: 26,
                    fontFamily: 'Nexa3',
                    color: renkler.koyuuRenk),
                bodyLarge: TextStyle(
                  ///alt YILLAR
                    fontSize: 16,
                    fontFamily: 'Nexa3',
                    color: Theme.of(context).disabledColor),
              ),
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: renkler.koyuuRenk, // üst taraf arkaplan rengi
                onPrimary: renkler.arkaRenk, //üst taraf yazı rengi
                secondary: renkler.kirmiziRenk,
                onSecondary: renkler.arkaRenk,
                primaryContainer: renkler.kirmiziRenk,
                error: const Color(0xFFD91A2A),
                onError: const Color(0xFFD91A2A),
                background: renkler.kirmiziRenk,
                onBackground: renkler.yesilRenk,
                surface: Theme.of(context).disabledColor, //ÜST TARAF RENK
                onPrimaryContainer: renkler.yesilRenk,
                onSurface: Theme.of(context).canvasColor, //alt günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          readAdd.selectedTime = picked;
          readAdd.operationTime.text =
              intl.DateFormat('HH:mm').format(readAdd.selectedDate!);
        });
      }
    }
    var readSettings = ref.read(settingsRiverpod);

    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).highlightColor,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 1,right: 10,left: 10),
              child: InkWell(
                onTap: () {
                  selectTime(context);
                },
                child: Center(
                    child: getLineText(readAdd.operationTime.text, Theme.of(context).canvasColor, 13,fontFamily: "Nexa4")),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toolCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return SizedBox(
      height: 30,
      child : getToggleSwitch(
          readAdd.initialLabelIndexForTool, 3,
          [translation(context).cash, translation(context).card, translation(context).otherPaye],
          size.width > 392 ? size.width * 0.18 : 70,
              (index) {
            if (index == 0) {
              readAdd.operationTool.text = "Nakit";
            } else if (index == 1) {
              readAdd.operationTool.text = "Kart";
            } else {
              readAdd.operationTool.text = "Diğer";
            }
            readAdd.initialLabelIndexForTool = index!;
          }
      ),);
  }

  Widget noteCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          children: [
            getTextFormField(translation(context).clickToAddNote,readAdd.maxLength,2,readAdd.note),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: readAdd.note.text.isNotEmpty,
                  child: getDecoratedBox(boxColor :Theme.of(context).canvasColor, 60, 18,
                    BorderRadius.all(Radius.circular(5)),
                    child : GestureDetector(
                      onTap: () {
                        setState(() {
                          readAdd.note.text = "";
                        });
                      },
                      child: Center(
                        child: getLineText(translation(context).delete,Theme.of(context).primaryColor,11,fontFamily: "Nexa3",weight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                    child: Center(child: getLineText('${readAdd.note.text.length}/${readAdd.maxLength.toString()}', Theme.of(context).canvasColor, 12,fontFamily: "Nexa3",weight: FontWeight.w800,backgroundColor: Theme.of(context).splashColor))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextFormField(String hintText,int maxLength,int maxLines,TextEditingController? controller,{EdgeInsetsGeometry? padding,}){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        textAlign: TextAlign.end,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).canvasColor,
            ),
            counterText: "",
            border: InputBorder.none),
        cursorRadius: const Radius.circular(10),
        autofocus: false,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: (value) {
          setState(() {

          });
        },
        keyboardType: TextInputType.text,
        controller: controller,
        //maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }

  Widget regCustomButton(BuildContext context) {
    var readAdd = ref.read(addDataRiverpod);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: getLineText(readAdd.regsController == 1 ? "Kaydedilecek" : "", Theme.of(context).canvasColor, 13,fontFamily: "Nexa3",weight: FontWeight.w800),
        ),
        getDecoratedBox(30, 30, BorderRadius.all(Radius.circular(10)),boxColor: Theme.of(context).highlightColor,child: registration()),
      ],
    );
  }
  Widget registration() {
    var readAdd = ref.read(addDataRiverpod);
    if (readAdd.regsController == 0) {
      return GestureDetector(
          onTap: () {
            setState(() {
              readAdd.regsController = 1;
              readAdd.registration.text = '1';
            });
          },
          child: Center(
            child: Icon(
              Icons.bookmark_add_outlined,
              color: renkler.yaziRenk,
              size: 18,
            ),
          ));
    } else {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              readAdd.regsController = 0;
              readAdd.registration.text = '0';
            });
          },
          icon: Icon(
            Icons.bookmark,
            color: renkler.sariRenk,
            size: 18,
          ));
    }
  }

  Widget amountCustomButton() {
    var readAdd = ref.read(addDataRiverpod);
    String moneyActivate = readAdd.operationType.text == "Gider" ? "" : "1";

    String getSymbolForMoneyType() {
      String controller = readAdd.moneyType.text;
      print("controller");
      print(controller);
      if (controller == 'TRY$moneyActivate') {
        return '₺';
      } else if (controller == 'USD$moneyActivate') {
        return '\$';
      } else if (controller == 'EUR$moneyActivate') {
        return '€';
      } else if (controller == 'GBP$moneyActivate') {
        return '£';
      } else if (controller == 'KWD$moneyActivate') {
        return 'د.ك';
      } else if (controller == 'JOD$moneyActivate') {
        return 'د.أ';
      } else if (controller == 'IQD$moneyActivate') {
        return 'د.ع';
      } else if (controller == 'SAR$moneyActivate') {
        return 'ر.س';
      } else {
        setState(() {
          readAdd.moneyType.text = "${ref.read(settingsRiverpod).Prefix}$moneyActivate";
        });
        return getSymbolForMoneyType();
      }
    }

    String getSymbolForMoneyTypeForUpdateOrAgain(){
      String controller = readAdd.moneyType.text;
      if(controller == 'TRY$moneyActivate'|| controller == 'TRY'){
        readAdd.moneyType.text = 'TRY$moneyActivate';
        return '₺';
      }else if (controller == 'USD$moneyActivate'|| controller == 'USD'){
        readAdd.moneyType.text = 'USD$moneyActivate';
        return '\$';
      }
      else if (controller == 'EUR$moneyActivate' || controller == 'EUR'){
        readAdd.moneyType.text = 'EUR$moneyActivate';
        return '€';
      }
      else if (controller == 'GBP$moneyActivate'|| controller == 'GBP'){
        readAdd.moneyType.text = 'GBP$moneyActivate';
        return '£';
      }
      else if (controller == 'KWD$moneyActivate'|| controller == 'KWD'){
        readAdd.moneyType.text = 'KWD$moneyActivate';
        return 'د.ك';
      }
      else if (controller == 'JOD$moneyActivate'|| controller == 'JOD'){
        readAdd.moneyType.text = 'JOD$moneyActivate';
        return 'د.أ';
      }
      else if (controller == 'IQD$moneyActivate'|| controller == 'IQD'){
        readAdd.moneyType.text = 'IQD$moneyActivate';
        return 'د.ع';
      }
      else if (controller == 'SAR$moneyActivate'|| controller == 'SAR'){
        readAdd.moneyType.text = 'SAR$moneyActivate';
        return 'ر.س';
      }
      else{
        setState(() {
          readAdd.moneyType.text = "${controller.substring(0,3)}$moneyActivate";
        });
        return getSymbolForMoneyType();
      }
    }

    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        readAdd.openMoneyTypeMenu == false
            ? Container(
              width: 112,
              height: 34,
              decoration:  BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).disabledColor,
              ),
              child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xff0D1C26),
                      fontSize: 17,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w100),
                  controller: readAdd.amount,
                  autofocus: false,
                  keyboardType: const TextInputType
                      .numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,7}(\.\d{0,2})?'),
                    )
                  ],
                  textAlign: TextAlign.center,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: "00.00",
                      hintStyle: TextStyle(
                        color: renkler.koyuAraRenk,
                      ),
                      contentPadding:
                      const EdgeInsets.only(
                          top: 10))),
            )
            : const SizedBox(),

        readAdd.openMoneyTypeMenu == false
            ? const SizedBox(width: 5,)
            : const SizedBox(),

        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              readAdd.openMoneyTypeMenu == false
                  ? readAdd.openMoneyTypeMenu = true
                  : readAdd.openMoneyTypeMenu = false;
              readAdd.openMoneyTypeMenu == true
                  ? readAdd.moneyTypeWidth = 250
                  : readAdd.moneyTypeWidth = 34;
              readAdd.openMoneyTypeMenu == true
                  ? readAdd.moneyTypeHeight = 80
                  : readAdd.moneyTypeHeight = 34;
            });
          },
          child: Container(
            height: readAdd.moneyTypeHeight,
            width: readAdd.moneyTypeWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).disabledColor,
            ),
            child: readAdd.openMoneyTypeMenu == false
                ? Center(
              child: getLineText(widget.addDataMode == 0 ? getSymbolForMoneyType() : getSymbolForMoneyTypeForUpdateOrAgain(), renkler.koyuuRenk, 22,fontFamily: "TL",weight: FontWeight.w500),)
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'TRY$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"TRY"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'USD$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"USD"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'EUR$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"EUR"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'GBP$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"GBP"),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'KWD$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"KWD"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'JOD$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"JOD"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'IQD$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"IQD"),
                    getAmountContainer(() {
                      setState(() {
                        readAdd.moneyType.text = 'SAR$moneyActivate';
                        readAdd.openMoneyTypeMenu = false;
                        readAdd.moneyTypeWidth = 34.0;
                        readAdd.moneyTypeHeight = 34.0;
                      });
                    },"SAR"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getAmountContainer(Function()? onTap,String text){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(15)),
          color: renkler.koyuuRenk,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Nexa4',
                color: renkler.arkaRenk),
          ),
        ),
      ),
    );

  }

  Widget categoryBarCustom(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readHome = ref.read(homeRiverpod);
    var readAdd = ref.read(addDataRiverpod);
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: InkWell(
        highlightColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30),
        child: Center(
          child: Text(
            readAdd.category.text == ""
                ? translation(context).tapToSelect
                : readAdd.category.text,
            style: TextStyle(
                height: 1,
                fontSize: 14,
                fontFamily: 'Nexa3',
                color: renkler.yaziRenk),
            maxLines: 2,
          ),
        ),
        onTap: () {
          setState(() {
            readAdd.editChanger = 0;
            readAdd.heightChanger = 40.0;
            //readAdd.category.clear();
            readAdd.selectedValue = null;
          });
          showDialog(
            context: context,
            builder: (context) {
              return CategoryMenu();
            },
          ).then((_) => setState(() {}));
        },
      ),
    );
  }

  Widget customizeBarCustom(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    return InkWell(
      highlightColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).highlightColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  readAdd.customize.text == ""
                      ? translation(context).tapToCustomize
                      : readAdd.initialLabelIndexCustomize  == 0
                      ? '${translation(context).tekrarTurkEmpty} ${readAdd.customize.text} ${translation(context).turkTekrarOnly}' /// Uyuşmamalar nedeniyle bu şekilde çevrilmiştir
                      : '${translation(context).taksitArabicOnly} ${readAdd.customize.text} ${translation(context).ayTaksitArapcaEpty} ${translation(context).taksitDevamArabicOnly}',
                  maxLines: 2,
                  style: TextStyle(
                      height: 1,
                      fontSize: 14,
                      fontFamily: 'Nexa3',
                      color: Theme.of(context).canvasColor),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.manage_history_rounded,
                color: Theme.of(context).secondaryHeaderColor,
                size: 22,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          readAdd.customize.clear();
          readAdd.selectedValueCustomize = null;
        });
        showDialog(
          context: context,
          builder: (context) {
            return CustomizeMenu(addDataMode: widget.addDataMode,);
          },
        ).then((_) => setState(() {}));
      },
    );
  }
}