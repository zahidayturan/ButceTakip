import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import '../riverpod_management.dart';
import 'package:butcekontrol/classes/language.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);
  @override
  State<UpdateData> createState() => _AddDataState();
}

class _AddDataState extends State<UpdateData> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _AddAppBar(),
        body: ButtonMenu(),
        bottomNavigationBar: null,
      ),
    );
  }
}

class _AddAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AddAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                height: 60,
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xff0D1C26),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      translation(context).editTitle,
                      style: const TextStyle(
                        height: 1,
                        fontFamily: 'Nexa4',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: SizedBox(
                height: 60,
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Color(0xffF2CB05),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(100),
                      )),
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 1.0),
                    iconSize: 60,
                    icon: Image.asset(
                      "assets/icons/remove.png",
                      height: 26,
                      width: 26,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      read.setCurrentindex(0);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonMenu extends ConsumerStatefulWidget {
  const ButtonMenu({Key? key}) : super(key: key);
  @override
  ConsumerState<ButtonMenu> createState() => _ButtonMenu();
}

class _ButtonMenu extends ConsumerState<ButtonMenu> {

  FocusNode amountFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height*0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [typeCustomButton(context), dateCustomButton(context)],
            ),
            const SizedBox(
              height: 15,
            ),
            categoryBarCustomButton(context),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(width: 15,),
                Expanded(
                    child: categoryCustomButton(context)),
                const SizedBox(width: 15,),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                toolCustomButton(context),
                regCustomButton(context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            noteCustomButton(context),
            const SizedBox(
              //height: 15,
              height : 5,
            ),
            amountCustomButton(context),
            const SizedBox(
              height: 5,
            ),
            operationCustomButton(context),
          ],
        ),
      ),
    );
  }

  double heightType_ = 34;
  double heightType2_ = 42;
  Color _containerColorType2 = const Color(0xff0D1C26);
  Color _containerColorType = const Color(0xffF2CB05);
  Color _textColorType = const Color(0xff0D1C26);
  Color _textColorType2 = Colors.white;
  Widget typeCustomButton(BuildContext context) {

    var readUpdateData = ref.read(updateDataRiverpod);
    final operationType = readUpdateData.getType();
    final category = readUpdateData.getCategory();
    int indexx ;
    operationType.text == 'Gider' ? indexx = 0: indexx =1;

    if(indexx == 0){
        heightType2_ = 40;
        heightType_ = 34;
        _containerColorType = const Color(0xffF2CB05);
        _containerColorType2 = const Color(0xff0D1C26);
        _textColorType = const Color(0xff0D1C26);
        _textColorType2 = Colors.white;
        selectedCategory = 0;
    }
    else{
        heightType_ = 40;
        heightType2_ = 34;
        _containerColorType2 = const Color(0xffF2CB05);
        _containerColorType = const Color(0xff0D1C26);
        _textColorType = Colors.white;
        _textColorType2 = const Color(0xff0D1C26);
        selectedCategory = 1;
    }
    void changeColorType(int index) {
      if (index == 0) {
        setState(() {
          heightType2_ = 40;
          heightType_ = 34;
          _containerColorType = const Color(0xffF2CB05);
          _containerColorType2 = const Color(0xff0D1C26);
          _textColorType = const Color(0xff0D1C26);
          _textColorType2 = Colors.white;
          index = 1;
          selectedCategory = 0;
        });
      } else {
        heightType_ = 40;
        heightType2_ = 34;
        _containerColorType2 = const Color(0xffF2CB05);
        _containerColorType = const Color(0xff0D1C26);
        _textColorType = Colors.white;
        _textColorType2 = const Color(0xff0D1C26);
        index = 0;
        selectedCategory = 1;
      }
    }

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 130,
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorType,
                ),
                height: heightType2_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeColorType(0);
                          operationType.text = "Gider";
                          selectedCategory = 0;
                          category.text = 'Yemek';
                          indexx = 1;
                        });
                      },
                      child: Text(translation(context).expenses,
                          style: TextStyle(
                            height: 1,
                              color: _textColorType,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorType2,
                ),
                height: heightType_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeColorType(1);
                          operationType.text = "Gelir";
                          selectedCategory = 1;
                          category.text = 'Harçlık';
                          indexx = 0;
                        });
                      },
                      child: Text(translation(context).income,
                          style: TextStyle(
                              height: 1,
                              color: _textColorType2,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime? _selectedDate;
  Widget dateCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final operationDate = readUpdateData.getOperationDate();
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        locale: const Locale("tr"),
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (context, child) {
          FocusScope.of(context).unfocus();
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: const TextTheme(
                  headlineLarge: TextStyle(
                      fontFamily: 'Nexa4', fontWeight: FontWeight.w900)),
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xff0D1C26), // üst taraf arkaplan rengi
                onPrimary: Colors.white,
                secondary: Color(0xff0D1C26),
                onSecondary: Color(0xFF1A8E58),
                error: Color(0xFFD91A2A),
                onError: Color(0xFFD91A2A),
                background: Color(0xffF2CB05),
                onBackground: Color(0xffF2CB05),
                surface: Color(0xffF2CB05),
                onSurface: Color(0xff0D1C26), //günlerin rengi
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          _selectedDate = picked;
          operationDate.text = intl.DateFormat('dd.MM.yyyy').format(_selectedDate!);
        });
      }
    }

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 205,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(translation(context).date,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color(0xffF2CB05),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 130,
                    child: TextFormField(
                      focusNode: dateFocusNode,
                      onTap: () {
                        selectDate(context);
                        FocusScope.of(context).unfocus();
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      style: const TextStyle(
                          color: Color(0xff0D1C26),
                          fontSize: 17,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800),
                      controller: operationDate,
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget amountCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final amount = readUpdateData.getAmount();
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 40,
      width: size.width * 0.9,
      child: Stack(
        children: [
          Positioned(
            top: 18,
            child: Container(
              width: size.width * 0.9,
              height: 4,
              decoration: const BoxDecoration(
                  color: Color(0xff0D1C26),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 185,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Text(translation(context).amountDetails,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color(0xffF2CB05),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 110,
                    child: TextFormField(
                        onTap: () {
                          //amount.clear();
                        },
                        style: const TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w100),
                        controller: amount,
                        autofocus: false,
                        focusNode: amountFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,5}(\.\d{0,2})?'),),
                        ],
                        textAlign: TextAlign.center,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: "00.00",
                            contentPadding: EdgeInsets.only(top: 12))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int selectedCategory = 0;
  Color colorContainerYemek = const Color(0xffF2CB05);
  Color colorContainerGiyim = Colors.white;
  Color colorContainerEglence = Colors.white;
  Color colorContainerEgitim = Colors.white;
  Color colorContainerAidat = Colors.white;
  Color colorContainerAlisveris = Colors.white;
  Color colorContainerOzel = Colors.white;
  Color colorContainerUlasim = Colors.white;
  Color colorContainerSaglik = Colors.white;
  Color colorContainerGunluk = Colors.white;
  Color colorContainerHobi = Colors.white;
  Color colorContainerDiger = Colors.white;

  Color colorTextYemek = Colors.white;
  Color colorTextGiyim = const Color(0xff0D1C26);
  Color colorTextEglence = const Color(0xff0D1C26);
  Color colorTextEgitim = const Color(0xff0D1C26);
  Color colorTextAidat = const Color(0xff0D1C26);
  Color colorTextAlisveris = const Color(0xff0D1C26);
  Color colorTextOzel = const Color(0xff0D1C26);
  Color colorTextUlasim = const Color(0xff0D1C26);
  Color colorTextSaglik = const Color(0xff0D1C26);
  Color colorTextGunluk = const Color(0xff0D1C26);
  Color colorTextHobi = const Color(0xff0D1C26);
  Color colorTextDiger = const Color(0xff0D1C26);
  Widget categoryCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
  final category = readUpdateData.getCategory();
    void resetColor() {
      colorContainerYemek = Colors.white;
      colorContainerGiyim = Colors.white;
      colorContainerEglence = Colors.white;
      colorContainerEgitim = Colors.white;
      colorContainerAidat = Colors.white;
      colorContainerAlisveris = Colors.white;
      colorContainerOzel = Colors.white;
      colorContainerUlasim = Colors.white;
      colorContainerSaglik = Colors.white;
      colorContainerGunluk = Colors.white;
      colorContainerHobi = Colors.white;
      colorContainerDiger = Colors.white;
      colorTextYemek = const Color(0xff0D1C26);
      colorTextGiyim = const Color(0xff0D1C26);
      colorTextEglence = const Color(0xff0D1C26);
      colorTextEgitim = const Color(0xff0D1C26);
      colorTextAidat = const Color(0xff0D1C26);
      colorTextAlisveris = const Color(0xff0D1C26);
      colorTextOzel = const Color(0xff0D1C26);
      colorTextUlasim = const Color(0xff0D1C26);
      colorTextSaglik = const Color(0xff0D1C26);
      colorTextGunluk = const Color(0xff0D1C26);
      colorTextHobi = const Color(0xff0D1C26);
      colorTextDiger = const Color(0xff0D1C26);
    }
      if (category.text == 'Yemek' || category.text == 'Harçlık') {
        resetColor();
        colorContainerYemek = const Color(0xffF2CB05);
        colorTextYemek = Colors.white;
      } else if (category.text == 'Giyim' || category.text == 'Burs') {
        resetColor();
        colorContainerGiyim = const Color(0xffF2CB05);
        colorTextGiyim = Colors.white;
      } else if (category.text == 'Eğlence' || category.text == 'Maaş') {
        resetColor();
        colorContainerEglence = const Color(0xffF2CB05);
        colorTextEglence = Colors.white;
      } else if (category.text == 'Eğitim' || category.text == 'Kredi') {
        resetColor();
        colorContainerEgitim = const Color(0xffF2CB05);
        colorTextEgitim = Colors.white;
      } else if (category.text == 'Aidat/Kira' || category.text == 'Özel+') {
        resetColor();
        colorContainerAidat = const Color(0xffF2CB05);
        colorTextAidat = Colors.white;
      } else if (category.text == 'Alışveriş' || category.text == 'Kira/Ödenek') {
        resetColor();
        colorContainerAlisveris = const Color(0xffF2CB05);
        colorTextAlisveris = Colors.white;
      } else if (category.text == 'Özel-' || category.text == 'Fazla Mesai') {
        resetColor();
        colorContainerOzel = const Color(0xffF2CB05);
        colorTextOzel = Colors.white;
      } else if (category.text == 'Ulaşım' || category.text == 'İş Getirisi') {
        resetColor();
        colorContainerUlasim = const Color(0xffF2CB05);
        colorTextUlasim = Colors.white;
      } else if (category.text == 'Sağlık' || category.text == 'Döviz Getirisi') {
        resetColor();
        colorContainerSaglik = const Color(0xffF2CB05);
        colorTextSaglik = Colors.white;
      } else if (category.text == 'Günlük Yaşam' || category.text == 'Yatırım Getirisi') {
        resetColor();
        colorContainerGunluk = const Color(0xffF2CB05);
        colorTextGunluk = Colors.white;
      } else if (category.text == 'Hobi' || category.text == 'Diğer+') {
        resetColor();
        colorContainerHobi = const Color(0xffF2CB05);
        colorTextHobi = Colors.white;
      } else if (category.text == 'Diğer-') {
        resetColor();
        colorContainerDiger = const Color(0xffF2CB05);
        colorTextDiger = Colors.white;
      }
    void changeCategoryColor1(int index) {
      if (index == 1) {
        resetColor();
        colorContainerYemek = const Color(0xffF2CB05);
        colorTextYemek = Colors.white;
      } else if (index == 2) {
        resetColor();
        colorContainerGiyim = const Color(0xffF2CB05);
        colorTextGiyim = Colors.white;
      } else if (index == 3) {
        resetColor();
        colorContainerEglence = const Color(0xffF2CB05);
        colorTextEglence = Colors.white;
      } else if (index == 4) {
        resetColor();
        colorContainerEgitim = const Color(0xffF2CB05);
        colorTextEgitim = Colors.white;
      } else if (index == 5) {
        resetColor();
        colorContainerAidat = const Color(0xffF2CB05);
        colorTextAidat = Colors.white;
      } else if (index == 6) {
        resetColor();
        colorContainerAlisveris = const Color(0xffF2CB05);
        colorTextAlisveris = Colors.white;
      } else if (index == 7) {
        resetColor();
        colorContainerOzel = const Color(0xffF2CB05);
        colorTextOzel = Colors.white;
      } else if (index == 8) {
        resetColor();
        colorContainerUlasim = const Color(0xffF2CB05);
        colorTextUlasim = Colors.white;
      } else if (index == 9) {
        resetColor();
        colorContainerSaglik = const Color(0xffF2CB05);
        colorTextSaglik = Colors.white;
      } else if (index == 10) {
        resetColor();
        colorContainerGunluk = const Color(0xffF2CB05);
        colorTextGunluk = Colors.white;
      } else if (index == 11) {
        resetColor();
        colorContainerHobi = const Color(0xffF2CB05);
        colorTextHobi = Colors.white;
      } else if (index == 12) {
        resetColor();
        colorContainerDiger = const Color(0xffF2CB05);
        colorTextDiger = Colors.white;
      }
    }

    var size = MediaQuery.of(context).size;
    if (selectedCategory == 0) {
      return SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerYemek,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(1);
                          category.text = 'Yemek';
                        });
                      },
                      child: Text("Yemek",
                          style: TextStyle(
                              color: colorTextYemek,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGiyim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(2);
                          category.text = 'Giyim';
                        });
                      },
                      child: Text("Giyim",
                          style: TextStyle(
                              color: colorTextGiyim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEglence,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(3);
                          category.text = 'Eğlence';
                        });
                      },
                      child: Text("Eğlence",
                          style: TextStyle(
                              color: colorTextEglence,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEgitim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(4);
                          category.text = 'Eğitim';
                        });
                      },
                      child: Text("Eğitim",
                          style: TextStyle(
                              color: colorTextEgitim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAidat,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(5);
                          category.text = 'Aidat/Kira';
                        });
                      },
                      child: Text("Aidat/Kira",
                          style: TextStyle(
                              color: colorTextAidat,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAlisveris,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(6);
                          category.text = 'Alışveriş';
                        });
                      },
                      child: Text("Alışveriş",
                          style: TextStyle(
                              color: colorTextAlisveris,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerOzel,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(7);
                          category.text = 'Özel-';
                        });
                      },
                      child: Text("Özel",
                          style: TextStyle(
                              color: colorTextOzel,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerUlasim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(8);
                          category.text = 'Ulaşım';
                        });
                      },
                      child: Text("Ulaşım",
                          style: TextStyle(
                              color: colorTextUlasim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerSaglik,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(9);
                          category.text = 'Sağlık';
                        });
                      },
                      child: Text("Sağlık",
                          style: TextStyle(
                              color: colorTextSaglik,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGunluk,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(10);
                          category.text = 'Günlük Yaşam';
                        });
                      },
                      child: Text("Günlük Yaşam",
                          style: TextStyle(
                              color: colorTextGunluk,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerHobi,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(11);
                          category.text = 'Hobi';
                        });
                      },
                      child: Text("Hobi",
                          style: TextStyle(
                              color: colorTextHobi,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerDiger,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(12);
                          category.text = 'Diğer-';
                        });
                      },
                      child: Text("Diğer",
                          style: TextStyle(
                              color: colorTextDiger,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerYemek,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(1);
                          category.text = 'Harçlık';
                        });
                      },
                      child: Text("Harçlık",
                          style: TextStyle(
                              color: colorTextYemek,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGiyim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(2);
                          category.text = 'Burs';
                        });
                      },
                      child: Text("Burs",
                          style: TextStyle(
                              color: colorTextGiyim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEglence,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(3);
                          category.text = 'Maaş';
                        });
                      },
                      child: Text("Maaş",
                          style: TextStyle(
                              color: colorTextEglence,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerEgitim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(4);
                          category.text = 'Kredi';
                        });
                      },
                      child: Text("Kredi",
                          style: TextStyle(
                              color: colorTextEgitim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAidat,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(5);
                          category.text = 'Özel+';
                        });
                      },
                      child: Text("Özel",
                          style: TextStyle(
                              color: colorTextAidat,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerAlisveris,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(6);
                          category.text = 'Kira/Ödenek';
                        });
                      },
                      child: Text("Kira/Ödenek",
                          style: TextStyle(
                              color: colorTextAlisveris,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerOzel,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(7);
                          category.text = 'Fazla Mesai';
                        });
                      },
                      child: Text("Fazla Mesai",
                          style: TextStyle(
                              color: colorTextOzel,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerUlasim,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(8);
                          category.text = 'İş Getirisi';
                        });
                      },
                      child: Text("İş Getirisi",
                          style: TextStyle(
                              color: colorTextUlasim,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerSaglik,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(9);
                          category.text = 'Döviz Getirisi';
                        });
                      },
                      child: Text("Döviz Getirisi",
                          style: TextStyle(
                              color: colorTextSaglik,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerGunluk,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(10);
                          category.text = 'Yatırım Getirisi';
                        });
                      },
                      child: Text("Yatırım Getirisi",
                          style: TextStyle(
                              color: colorTextGunluk,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: colorContainerHobi,
                  ),
                  height: 34,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          changeCategoryColor1(11);
                          category.text = 'Diğer+';
                        });
                      },
                      child: Text("Diğer",
                          style: TextStyle(
                              color: colorTextHobi,
                              fontSize: 18,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w700))),
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  double heightTool_ = 34;
  double heightTool2_ = 42;
  double heightTool3_ = 34;
  Color _containerColorTool3 = const Color(0xff0D1C26);
  Color _containerColorTool2 = const Color(0xff0D1C26);
  Color _containerColorTool = const Color(0xffF2CB05);
  Color _textColorTool = const Color(0xff0D1C26);
  Color _textColorTool2 = Colors.white;
  Color _textColorTool3 = Colors.white;
  int index = 0;
  Widget toolCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final operationTool = readUpdateData.getOperationTool();
    if(operationTool.text == 'Nakit'){
      heightTool2_ = 40;
      heightTool_ = 34;
      heightTool3_ = 34;
      _containerColorTool = const Color(0xffF2CB05);
      _containerColorTool2 = const Color(0xff0D1C26);
      _containerColorTool3 = const Color(0xff0D1C26);
      _textColorTool = const Color(0xff0D1C26);
      _textColorTool2 = Colors.white;
      _textColorTool3 = Colors.white;
    }
    else if(operationTool.text == 'Kart'){
      heightTool_ = 40;
      heightTool2_ = 34;
      heightTool3_ = 34;
      _containerColorTool2 = const Color(0xffF2CB05);
      _containerColorTool = const Color(0xff0D1C26);
      _containerColorTool3 = const Color(0xff0D1C26);
      _textColorTool = Colors.white;
      _textColorTool2 = const Color(0xff0D1C26);
      _textColorTool3 = Colors.white;
    }
    else{
      heightTool_ = 34;
      heightTool2_ = 34;
      heightTool3_ = 40;
      _containerColorTool3 = const Color(0xffF2CB05);
      _containerColorTool = const Color(0xff0D1C26);
      _containerColorTool2 = const Color(0xff0D1C26);
      _textColorTool = Colors.white;
      _textColorTool2 = Colors.white;
      _textColorTool3 = const Color(0xff0D1C26);
    }


    void changeColor(int index) {
      if (index == 0) {
        setState(() {
          heightTool2_ = 40;
          heightTool_ = 34;
          heightTool3_ = 34;
          _containerColorTool = const Color(0xffF2CB05);
          _containerColorTool2 = const Color(0xff0D1C26);
          _containerColorTool3 = const Color(0xff0D1C26);
          _textColorTool = const Color(0xff0D1C26);
          _textColorTool2 = Colors.white;
          _textColorTool3 = Colors.white;
        });
      } else if (index == 1) {
        setState(() {
          heightTool_ = 40;
          heightTool2_ = 34;
          heightTool3_ = 34;
          _containerColorTool2 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xff0D1C26);
          _containerColorTool3 = const Color(0xff0D1C26);
          _textColorTool = Colors.white;
          _textColorTool2 = const Color(0xff0D1C26);
          _textColorTool3 = Colors.white;
        });
      } else {
        setState(() {
          heightTool_ = 34;
          heightTool2_ = 34;
          heightTool3_ = 40;
          _containerColorTool3 = const Color(0xffF2CB05);
          _containerColorTool = const Color(0xff0D1C26);
          _containerColorTool2 = const Color(0xff0D1C26);
          _textColorTool = Colors.white;
          _textColorTool2 = Colors.white;
          _textColorTool3 = const Color(0xff0D1C26);
        });
      }
    }

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 205,
            ),
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool,
                ),
                height: heightTool2_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          operationTool.text = "Nakit";
                          changeColor(0);
                        });
                      },
                      child: Text(translation(context).cash,
                          style: TextStyle(
                              height: 1,
                              color: _textColorTool,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool2,
                ),
                height: heightTool_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          operationTool.text = "Kart";
                          changeColor(1);
                        });
                      },
                      child: Text(translation(context).card,
                          style: TextStyle(
                              height: 1,
                              color: _textColorTool2,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: _containerColorTool3,
                ),
                height: heightTool3_,
                child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          operationTool.text = "Diger";
                          changeColor(2);
                        });
                      },
                      child: Text(translation(context).otherPaye,
                          style: TextStyle(
                              height: 1,
                              color: _textColorTool3,
                              fontSize: 17,
                              fontFamily: 'Nexa4',
                              fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryBarCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 40,
      width: size.width * 0.9,
      child: Stack(
        children: [
          Positioned(
            top: 18,
            child: Container(
              width: size.width * 0.9,
              height: 4,
              decoration: const BoxDecoration(
                  color: Color(0xff0D1C26),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          Center(
            child: Container(
              width: 130,
              height: 40,
              decoration: const BoxDecoration(
                  color: Color(0xff0D1C26),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Text(translation(context).categoryDetails,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w800))),
            ),
          ),
        ],
      ),
    );
  }

  int regss = 0;
  Widget regCustomButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xff0D1C26),
              ),
              height: 34,
              width: 130,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(translation(context).save,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF2CB05),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: registration(regss),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registration(int regs) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final registration = readUpdateData.getRegistration();
    if(registration.text== '0'){
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 1;
              registration.text = '1';
            });
          },
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          ));
    }
    else{
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 0;
              registration.text = '0';
            });
          },
          icon: const Icon(
            Icons.bookmark,
            color: Color(0xff0D1C26),
          ));
    }
  }

  int maxLength = 108;
  int textLength = 0;
  Widget noteCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    final note = readUpdateData.getNote();
    var size = MediaQuery.of(context).size;
    var readSettings = ref.read(settingsRiverpod);
    return SizedBox(
      width: size.width * 0.9,
      height: 125,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 90,
              width: size.width * 0.9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border:
                      Border.all(color: const Color(0xff0D1C26), width: 1.5),
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.88,
            height: 115,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: translation(context).clickToAddNote,
                        counterText: "",
                        border: InputBorder.none),
                    cursorRadius: const Radius.circular(10),
                    autofocus: false,
                    maxLength: maxLength,
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        textLength = value.length;
                      });
                    },
                    keyboardType: TextInputType.text,
                    controller: note,
                    //maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 20,
                    child: Text(
                      '${textLength.toString()}/${maxLength.toString()}',
                      style: const TextStyle(
                        backgroundColor: Colors.white,
                        color: Color(0xffF2CB05),
                        fontSize: 13,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
            left: 20,
            child: SizedBox(
              width: 130,
              height: 40,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff0D1C26),
                ),
                child: Padding(
                  padding: readSettings.localChanger() == const Locale("en") ?
                  const EdgeInsets.only(left: 15, top: 12) :
                  const EdgeInsets.only(left: 18, right: 18, top: 12), /// ingilzce olunc yazı sığmıyor o yüzden koşul koydum
                  child: SizedBox(
                    child: Text(
                      translation(context).addNote,
                      style: const TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 8,
            child: SizedBox(
              width: 60,
              height: 26,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xffF2CB05),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      note.text = "";
                    });
                  },
                  child: Text(
                    translation(context).delete,
                    style: const TextStyle(
                      height: 1,
                      color: Color(0xff0D1C26),
                      fontSize: 12,
                      fontFamily: 'Nexa4',
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget operationCustomButton(BuildContext context) {
    var readUpdateData = ref.read(updateDataRiverpod);
    var read = ref.read(databaseRiverpod);
    var readHome = ref.read(homeRiverpod);
    final id = readUpdateData.getId();
    final operationType = readUpdateData.getType();
    final note = readUpdateData.getNote();
    final amount0 = readUpdateData.getAmount();
    final category = readUpdateData.getCategory();
    final operationTool = readUpdateData.getOperationTool();
    final operationDate = readUpdateData.getOperationDate();
    final registration = readUpdateData.getRegistration();
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: 70,
      child: Center(
        child: SizedBox(
          width: 140,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xffF2CB05),
                ),
                height: 40,
                width: 140,
                child: TextButton(
                  onPressed: () {
                    double amount = double.tryParse(amount0.text) ?? 0.0;
                    if (amount != 0.0) {
                          readUpdateData.updateDataBase(
                          int.parse(id),
                          operationType.text,
                          category.text,
                          operationTool.text,
                          int.parse(registration.text),
                          amount,
                          note.text,
                          operationDate.text);
                          read.update();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      readHome.setStatus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                          const Color(0xff0D1C26),
                          duration: const Duration(seconds: 1),
                          content: Text(
                            translation(context).activityUpdated,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nexa3',
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(translation(context).missingEntry),
                              content: Text(translation(context).pleaseEnterAnAmount),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    amount0.clear();
                                    FocusScope.of(context)
                                        .requestFocus(amountFocusNode);
                                  },
                                  child: Text(translation(context).ok),
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Text(translation(context).updateDone,
                      style: const TextStyle(
                          color: Color(0xff0D1C26),
                          fontSize: 17,
                          fontFamily: 'Nexa4',
                          fontWeight: FontWeight.w900)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
