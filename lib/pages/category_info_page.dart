import 'package:butcetakip/UI/spend_detail.dart';
import 'package:butcetakip/constants/material_color.dart';
import 'package:butcetakip/riverpod_management.dart';
import 'package:butcetakip/utils/textConverter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app/data/models/spend_info.dart';
import '../l10n/language.dart';

class CategoryInfo extends ConsumerWidget {
  const CategoryInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CustomColors renkler = CustomColors();
    return Container(
      color: renkler.koyuuRenk,
      child: const SafeArea(
        child: Scaffold(
          bottomNavigationBar: null,
          //backgroundColor: renkler.arkaRenk,
          appBar: AppbarCategoryInfo(),
          body: CategoryInfoBody(),
        ),
      ),
    );
  }
}

class CategoryInfoBody extends ConsumerStatefulWidget {
  const CategoryInfoBody({Key? key}) : super(key: key);
  @override
  ConsumerState<CategoryInfoBody> createState() => _CategoryInfoBody();
}

class _CategoryInfoBody extends ConsumerState<CategoryInfoBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class AppbarCategoryInfo extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarCategoryInfo({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(80);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readSettings = ref.read(settingsRiverpod);
    var read = ref.read(categoryInfoRiverpod);
    var size = MediaQuery.of(context).size;
    CustomColors renkler = CustomColors();
    List myCategory = read.getCategory(context);
    List myDate = read.getDate(context);
    print(myDate);
    String textConverter(){
      String text = '';
      for(int i =0 ; i<myDate.length ; i++){
        text = '$text ${myDate[i].toString()}';
      }
      return text;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 66,
              width: size.width - 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: readSettings.localChanger() == const Locale("ar") ?
                  const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ) :
                  const BorderRadius.horizontal(
                    right: Radius.circular(15),
                  ),
                  color: Theme.of(context).highlightColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                          padding: const EdgeInsets.only(left: 4,right: 4,bottom: 4),
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: myCategory[2] == "Gider" ? renkler.kirmiziRenk :renkler.yesilRenk
                            ),
                          ),
                        ),
                          Text(
                            '${Converter().textConverterFromDB(myCategory[0], context, 0)} ',
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "FontMedium",
                              height: 1,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ' ${myCategory[1]}',
                            style: TextStyle(
                              color: renkler.yaziRenk,
                              fontFamily: "FontMedium",
                              height: 1,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      textConverter(),
                      style: TextStyle(
                        color: renkler.yaziRenk,
                        height: 1,
                        fontFamily: "FontMedium",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ), /// başlıktaki yazılar
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15,),
              child: SizedBox(
                width: 40,
                height: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    highlightColor: Theme.of(context).primaryColor,
                    splashColor:Theme.of(context).primaryColor,
                    icon:  Image.asset(
                      "assets/icons/remove.png",
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ), /// çarpı işareti
          ],
        ),
      ),
    );
  }
}
