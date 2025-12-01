import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/language.dart';

class myAssistant extends ConsumerStatefulWidget {
  const myAssistant({Key? key}) : super(key: key);

  @override
  ConsumerState<myAssistant> createState() => _myAssistant();
}

class _myAssistant extends ConsumerState<myAssistant> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: GestureDetector(
                  onTap:() {

                  },
                  child: FittedBox(
                    child: Container( //boyut
                      width: 330,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Column (
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    translation(context).analysis,
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontFamily: 'FontBold',
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 10, left: 10),
                                    width: 32,
                                    height: 32,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Image.asset(
                                          "assets/icons/remove.png",
                                          color: const Color(0xffF2F2F2),
                                          height: 18,
                                          width: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/image/noInfo5.png",
                                    width: 75,
                                    height: 75,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "${translation(context).iAmYourBudgetWiseAssistant} ${translation(context).lookAtYourMonthlyExpenses}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontFamily: "FontBold",
                                          fontSize: 13,
                                          height: 1
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int foundMaxdayinMoth (){ //ayın kaç gün olduğunu buluyor.
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }
}
