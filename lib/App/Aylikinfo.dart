import 'package:butcekontrol/constans/MaterialColor.dart';
import 'package:butcekontrol/modals/Spendinfo.dart';
import 'package:butcekontrol/utils/dpHelper.dart';
import 'package:flutter/material.dart';

class Aylikinfo extends StatefulWidget {
  @override
  State<Aylikinfo> createState() => _AylikinfoState();
}
class _AylikinfoState extends State<Aylikinfo> {
  _AylikinfoState();
  List<spendinfo> _spendinfolist = [];
  Future<List<spendinfo>> ?_taskList;
  bool _isLoading = true;

  void _refreshSpendinfoList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _spendinfolist = data;
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshSpendinfoList();
  }

  @override
  Widget build(BuildContext context) {
    var ceyrekwsize = MediaQuery.of(context).size.width / 5;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 221,
            child: Padding(      //borderin scroll ile birleşimi gözüksü diye soldan padding
              padding: const EdgeInsets.only(left: 3.0),
              child: DecoratedBox( // border için
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 5,color: Color(0xFF0D1C26)))
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: MaterialStateProperty.all(Color(0xFFF2CB05)),
                    )
                  ),
                  child: Scrollbar(
                    scrollbarOrientation: ScrollbarOrientation.left,
                    isAlwaysShown: true,
                    interactive: true,
                    thickness: 8,
                    radius: Radius.circular(15.0),
                    child: ListView.builder(
                        itemCount : _spendinfolist.length,
                        itemBuilder: (BuildContext context, index) {
                          double? x = double.tryParse(_spendinfolist[index].gelir!) ;
                          double? y = double.tryParse(_spendinfolist[index].gider!) ;
                          String? toplam = (x! - y!).toString() ;
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: ClipRRect(           //Borderradius vermek için kullanıyoruz
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    height: 27.4,
                                    color:  CustomColors.ArkaRenk,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: ceyrekwsize ,
                                              child: Text(
                                                _spendinfolist[index].day.toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                          ),
                                          SizedBox(
                                            width: ceyrekwsize,
                                            child: Center(
                                              child: Text(
                                                this._spendinfolist[index].gelir.toString(),
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ceyrekwsize,
                                            child: Center(
                                              child: Text(
                                                _spendinfolist[index].gider.toString(),
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ceyrekwsize,
                                            child: Center(
                                              child: Text(
                                                "99",
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            constraints: const BoxConstraints(
                                              maxHeight: 30,
                                            ),
                                            padding: const EdgeInsets.all(1),
                                            icon: eyeColorChoice(12.2),
                                            onPressed: () {
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5)   // elemanlar arasına bşluk bırakmak için kulllandım.
                            ],
                          );
                        }
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed:() {
                SQLHelper.createItem(spendinfo("200", "200", "pazar", "Mayıs", "2023"));
                _refreshSpendinfoList();
              },
              child: Text("Ekle"),
          ),
          ElevatedButton(
            onPressed:() {
              SQLHelper.deleteItem(_spendinfolist[0].id!);
              _refreshSpendinfoList();
            },
            child: Text("Sil"),
          ),
        ],
      ),
    );
  }


  Widget eyeColorChoice(double toplam) {
    if(toplam < 0 ) {
      return const Icon(Icons.remove_red_eye,
      color: Colors.red,
      );
    }
    else {
      return const Icon(Icons.remove_red_eye,
      color: Colors.black
      );
    }
  }
}

