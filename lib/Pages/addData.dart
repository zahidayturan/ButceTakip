import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:butcekontrol/utils/DateTimeManager.dart';
import '../riverpod_management.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0D1C26),
      child: const SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _AddAppBar(),
          body: ButtonMenu(),
          bottomNavigationBar: null,
        ),
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
    return SizedBox(
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
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'GELİR / GİDER EKLE',
                    style: TextStyle(
                      fontFamily: 'Nexa4',
                      fontSize: 26,
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
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    read.setCurrentindex(read.current!);
                  },
                ),
              ),
            ),
          ),
        ],
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
  final TextEditingController _note = TextEditingController(text: "");
  final TextEditingController _amount = TextEditingController(text: "0.0");
  final TextEditingController _operationType =
      TextEditingController(text: "Gider");
  final TextEditingController _category = TextEditingController(text: "Yemek");
  final TextEditingController _operationTool =
      TextEditingController(text: "Nakit");
  final TextEditingController _registration = TextEditingController(text: "0");
  final TextEditingController _operationDate =
      TextEditingController(text: DateTimeManager.getCurrentDayMonthYear());
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [TypeCustomButton(context), DateCustomButton(context)],
            ),
            const SizedBox(
              height: 15,
            ),
            CategoryBarCustomButton(context),
            const SizedBox(
              height: 5,
            ),
            CategoryCustomButton(context),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ToolCustomButton(context),
                RegCustomButton(context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            NoteCustomButton(context),
            const SizedBox(
              height: 15,
            ),
            AmountCustomButton(),
            const SizedBox(
              height: 5,
            ),
            OperationCustomButton(context),
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
  Widget TypeCustomButton(BuildContext context) {
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
        });
      } else {
        heightType_ = 40;
        heightType2_ = 34;
        _containerColorType2 = const Color(0xffF2CB05);
        _containerColorType = const Color(0xff0D1C26);
        _textColorType = Colors.white;
        _textColorType2 = const Color(0xff0D1C26);
        index = 0;
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
                          _operationType.text = "Gider";
                          selectedCategory = 0;
                        });
                      },
                      child: Text("GİDER",
                          style: TextStyle(
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
                          _operationType.text = "Gelir";
                          selectedCategory = 1;
                          _category.text = 'Harçlık';
                        });
                      },
                      child: Text("GELİR",
                          style: TextStyle(
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
  Widget DateCustomButton(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
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
          _operationDate.text = DateFormat('dd.MM.yyyy').format(_selectedDate!);
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
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text("TARİH",
                        style: TextStyle(
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
                        _selectDate(context);
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
                      controller: _operationDate,
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


  Widget AmountCustomButton() {
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
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Text("TUTAR",
                        style: TextStyle(
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
                          _amount.clear();
                        },
                        style: const TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w100),
                        controller: _amount,
                        autofocus: false,
                        focusNode: amountFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+(\.\d{0,2})?')),
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
  Widget CategoryCustomButton(BuildContext context) {
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
                          _category.text = 'Yemek';
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
                          _category.text = 'Giyim';
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
                          _category.text = 'Eğlence';
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
                          _category.text = 'Eğitim';
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
                          _category.text = 'Aidat/Kira';
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
                          _category.text = 'Alışveriş';
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
                          _category.text = 'Özel-';
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
                          _category.text = 'Ulaşım';
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
                          _category.text = 'Sağlık';
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
                          _category.text = 'Günlük Yaşam';
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
                          _category.text = 'Hobi';
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
                          _category.text = 'Diğer-';
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
                          _category.text = 'Harçlık';
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
                          _category.text = 'Burs';
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
                          _category.text = 'Maaş';
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
                          _category.text = 'Kredi';
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
                          _category.text = 'Özel+';
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
                          _category.text = 'Kira/Ödenek';
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
                          _category.text = 'Fazla Mesai';
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
                          _category.text = 'İş Getirisi';
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
                          _category.text = 'Döviz Getirisi';
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
                          _category.text = 'Yatırım Getirisi';
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
                          _category.text = 'Diğer+';
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
  Widget ToolCustomButton(BuildContext context) {
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
                          _operationTool.text = "Nakit";
                          changeColor(0);
                        });
                      },
                      child: Text("NAKİT",
                          style: TextStyle(
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
                          _operationTool.text = "Kart";
                          changeColor(1);
                        });
                      },
                      child: Text("KART",
                          style: TextStyle(
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
                          _operationTool.text = "Diger";
                          changeColor(2);
                        });
                      },
                      child: Text("DİĞER",
                          style: TextStyle(
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

  Widget CategoryBarCustomButton(BuildContext context) {
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
              child: const Center(
                  child: Text("KATEGORİ",
                      style: TextStyle(
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
  Widget RegCustomButton(BuildContext context) {
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
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text("KAYDET",
                        style: TextStyle(
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
    if (regs == 0) {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 1;
              _registration.text = '1';
            });
          },
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          ));
    } else {
      return IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              regss = 0;
              _registration.text = '0';
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
  Widget NoteCustomButton(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  padding: const EdgeInsets.only(left: 18, top: 34),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Not eklemek için tıklayınız",
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
                    controller: _note,
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
          const Positioned(
            left: 20,
            child: SizedBox(
              width: 114,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff0D1C26),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 12),
                  child: Text(
                    "NOT EKLE",
                    style: TextStyle(
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
                      _note.text = "";
                    });
                  },
                  child: const Text(
                    "Temizle",
                    style: TextStyle(
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

  Widget OperationCustomButton(BuildContext context) {
    var read = ref.read(databaseRiverpod);
    var read2 = ref.read(botomNavBarRiverpod);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 100,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF2CB05),
                  ),
                  height: 34,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      _note.text = "";
                      _amount.text = "0.0";
                      OperationCustomButton(context);
                    },
                    child: const Text("SIFIRLA",
                        style: TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffF2CB05),
                  ),
                  height: 34,
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      double amount = double.tryParse(_amount.text) ?? 0.0;
                      if (amount != 0.0) {
                        read.insertDataBase(
                            _operationType.text,
                            _category.text,
                            _operationTool.text,
                            int.parse(_registration.text),
                            amount,
                            _note.text,
                            _operationDate.text);
                        Navigator.of(context).pop();
                        read2.setCurrentindex(0);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor:
                            Color(0xff0D1C26),
                            duration: Duration(seconds: 1),
                            content: Text(
                              'İşlem verisi eklendi',
                              style: TextStyle(
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
                                title: const Text("Eksik İşlem"),
                                content: const Text("Lütfen bir tutar girin!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _amount.clear();
                                      //FocusScope.of(context).requestFocus(amountFocusNode);
                                    },
                                    child: const Text("Tamam"),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: const Text("EKLE",
                        style: TextStyle(
                            color: Color(0xff0D1C26),
                            fontSize: 17,
                            fontFamily: 'Nexa4',
                            fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        cli, _harcamatipiController.text, _odemeyontemiController.text, _kategoriController.text, _tutarController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully updated'),
    ));
    _refreshSpendinfoList();
  }
*/
