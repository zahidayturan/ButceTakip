import 'package:butcekontrol/classes/language.dart';
import 'package:butcekontrol/constans/material_color.dart';
import 'package:butcekontrol/riverpod_management.dart';
import 'package:butcekontrol/utils/textConverter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomizeMenu extends ConsumerStatefulWidget {
  const CustomizeMenu({Key? key}) : super(key: key);
  @override
  ConsumerState<CustomizeMenu> createState() => _CustomizeMenu();
}

class _CustomizeMenu extends ConsumerState<CustomizeMenu> {

  CustomColors renkler = CustomColors();
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    var readAdd = ref.read(addDataRiverpod);
    List<String> repetitiveList = [
      translation(context).dailyAddData,
      translation(context).weeklyAddData,
      translation(context).biweekly,
      translation(context).monthlyAddData,
      translation(context).bimonthly,
      translation(context).everyThreeMonths,
      translation(context).everyFourMonths,
      translation(context).everySixMonths,
      translation(context).yearlyAddData,
    ];
    return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.black54,
        contentPadding: const EdgeInsets.only(
            top: 10, bottom: 10),
        insetPadding: const EdgeInsets.symmetric(
            horizontal: 15),
        shape: const RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(15))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: size.width * 0.95,
                    height: 92,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(
                            Radius.circular(15)),
                        border: Border.all(
                          width: 1.5,
                          color: Theme.of(context)
                              .secondaryHeaderColor,
                        )),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 281,
                        height: 30,
                        child: ToggleSwitch(
                          initialLabelIndex:
                          readAdd.initialLabelIndexCustomize,
                          totalSwitches: 2,
                          labels: [
                            translation(context).repeat,
                            translation(context).installment
                          ],
                          activeBgColor: [
                            Theme.of(context).disabledColor
                          ],
                          activeFgColor:
                          const Color(0xff0D1C26),
                          inactiveBgColor: Theme.of(context)
                              .highlightColor,
                          inactiveFgColor:
                          const Color(0xFFE9E9E9),
                          minWidth: 140,
                          cornerRadius: 20,
                          radiusStyle: true,
                          animate: true,
                          curve: Curves.linearToEaseOut,
                          customTextStyles: const [
                            TextStyle(
                                fontSize: 16,
                                height: 1,
                                fontFamily: 'Nexa4',
                                fontWeight: FontWeight.w800)
                          ],
                          onToggle: (index) {
                            setState(() {
                              if (index == 0) {
                                readAdd.selectedCustomizeMenu = 0;
                                readAdd.customize.clear();
                              } else {
                                readAdd.selectedCustomizeMenu = 1;
                                readAdd.customize.clear();
                              }
                              readAdd.initialLabelIndexCustomize =
                              index!;
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible : readAdd.selectedCustomizeMenu == 0,
                        child: SizedBox(
                          width: 280,
                          height: 60,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<
                                    String>(
                                  isExpanded: true,
                                  hint: Text(
                                    translation(context).select,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:
                                      'Nexa3',
                                      color: Theme.of(
                                          context)
                                          .canvasColor,
                                    ),
                                  ),
                                  items: repetitiveList
                                      .map((item) =>
                                      DropdownMenuItem(
                                        value: item,
                                        child: Center(
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                fontSize:
                                                18,
                                                fontFamily:
                                                'Nexa3',
                                                color:
                                                Theme.of(context).canvasColor),
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  value:
                                  readAdd.selectedValueCustomize,
                                  onChanged: (value) {
                                    setState(() {
                                      readAdd.selectedValueCustomize = value;
                                      readAdd.customize.text = value.toString();
                                      readAdd.convertedCustomize = Converter().textConverterToDB(readAdd.customize.text,context,1);
                                      this.setState(
                                              () {});
                                    });
                                  },
                                  barrierColor: renkler
                                      .koyuAraRenk
                                      .withOpacity(0.8),
                                  buttonStyleData:
                                  ButtonStyleData(
                                    overlayColor:
                                    MaterialStatePropertyAll(
                                        renkler
                                            .koyuAraRenk), // BAŞLANGIÇ BASILMA RENGİ
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        16),
                                    height: 40,
                                    width: 280,
                                  ),
                                  dropdownStyleData:
                                  DropdownStyleData(
                                      maxHeight:
                                      250,
                                      width: 280,
                                      decoration:
                                      BoxDecoration(
                                          color: Theme.of(
                                              context)
                                              .primaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(5))
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                          radius:
                                          const Radius.circular(
                                              15),
                                          thumbColor:
                                          MaterialStatePropertyAll(
                                              Theme.of(context).disabledColor))),
                                  menuItemStyleData:
                                  MenuItemStyleData(
                                    overlayColor:
                                    MaterialStatePropertyAll(
                                        renkler
                                            .koyuAraRenk), // MENÜ BASILMA RENGİ
                                    height: 40,
                                  ),
                                  iconStyleData:
                                  IconStyleData(
                                    icon: const Icon(
                                      Icons
                                          .arrow_drop_down,
                                    ),
                                    iconSize: 30,
                                    iconEnabledColor: Theme
                                        .of(context)
                                        .secondaryHeaderColor,
                                    iconDisabledColor:
                                    Theme.of(
                                        context)
                                        .secondaryHeaderColor,
                                    openMenuIcon: Icon(
                                      Icons.arrow_right,
                                      color: Theme.of(
                                          context)
                                          .canvasColor,
                                      size: 24,
                                    ),
                                  ),
                                  onMenuStateChange:
                                      (isOpen) {
                                    if (!isOpen) {
                                      readAdd.customize
                                          .clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible : readAdd.selectedCustomizeMenu == 1,
                        child: SizedBox(
                          width: 280,
                          height: 60,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                maxLength: 3,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Theme.of(
                                        context)
                                        .canvasColor,
                                    fontSize: 17,
                                    fontFamily:
                                    'Nexa3'),
                                decoration:
                                InputDecoration(
                                    hintText:
                                    translation(context).enterMonths,
                                    hintStyle: TextStyle(
                                        color: Theme.of(
                                            context)
                                            .canvasColor,
                                        fontSize:
                                        12.5,
                                        height: 1,
                                        fontFamily:
                                        'Nexa3'),
                                    suffixText:
                                    translation(context).month,
                                    suffixStyle:
                                    TextStyle(
                                      color: Theme.of(
                                          context)
                                          .canvasColor,
                                      fontSize: 15,
                                      height: 1,
                                      fontFamily:
                                      'Nexa3',
                                    ),
                                    counterText: '',
                                    border:
                                    InputBorder
                                        .none),
                                cursorRadius:
                                const Radius
                                    .circular(10),
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .allow(RegExp(
                                      r'^(1[0-4][0-4]|[1-9][0-9]|[1-9])$')),
                                ],
                                keyboardType:
                                const TextInputType
                                    .numberWithOptions(
                                    signed: false,
                                    decimal: false),
                                controller: readAdd.customize,
                                onChanged: (value) {
                                  setState(() {
                                    this.setState(
                                            () {});
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          readAdd.initialLabelIndexCustomize == 1
                              ? SizedBox(
                            width: 140,
                            height: 30,
                            child: Align(
                              alignment: Alignment
                                  .centerLeft,
                              child: FittedBox(
                                child: Text(
                                  translation(context).monthlyInstallment,
                                  style: TextStyle(
                                    backgroundColor:
                                    Theme.of(
                                        context)
                                        .primaryColor,
                                    color: const Color(
                                        0xffF2CB05),
                                    fontSize: 13,
                                    fontFamily: 'Nexa4',
                                    fontWeight:
                                    FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                              : SizedBox(
                            width: 110,
                            height: 26,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(
                                      Theme.of(
                                          context)
                                          .highlightColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5),
                                      ))),
                              onPressed: () {
                                setState(() {
                                  readAdd.selectedValueCustomize =
                                  null;
                                  readAdd.customize.text =
                                  "";
                                  this.setState(
                                          () {});
                                });
                              },
                              child: Text(
                                translation(context).remove,
                                style: TextStyle(
                                  color: renkler
                                      .arkaRenk,
                                  fontSize: 12,
                                  fontFamily: 'Nexa3',
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll(
                                      Theme.of(context).disabledColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(10),
                                      ))),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                translation(context).doneCategory,
                                style: TextStyle(
                                    color: renkler.koyuuRenk,
                                    fontSize: 16,
                                    fontFamily: 'Nexa3',
                                    height: 1
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

}