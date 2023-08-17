import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod_management.dart';

class listBackUpPopUp extends ConsumerStatefulWidget{
  const listBackUpPopUp({Key? key}) : super(key: key);

  @override
  ConsumerState<listBackUpPopUp> createState() => _listBackUpPopUp();
}

class _listBackUpPopUp extends ConsumerState<listBackUpPopUp> {
  Future<List> ?backUpList  ;

  @override
  Widget build(BuildContext context) {
    var readGglAuth = ref.read(gglDriveRiverpod);
    backUpList = readGglAuth.ListOfFolder(readGglAuth.folderID);
    var errormessage = "";
    var readSettings = ref.read(settingsRiverpod);
    var size = MediaQuery.of(context).size;
    var renkler = CustomColors();
    return SafeArea(
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
                onTap: () {

                },
                child: Container( //boyut
                  height: size.width * .7,
                  width: size.width * .65,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: renkler.koyuuRenk,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FutureBuilder(
                    future: backUpList,
                    builder:(context, snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot.data!.toList();
                        if(data.length > 30){

                        }
                        return Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch(
                                accentColor: const Color(0xFFF2CB05),
                              ),
                              scrollbarTheme: ScrollbarThemeData(
                                thumbColor:
                                MaterialStateProperty.all(Theme.of(context).dialogBackgroundColor),
                              )),
                          child: Scrollbar(
                            thickness: 5,
                            thumbVisibility: true ,
                            child: ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                     InkWell(
                                       onTap:() async {
                                         print("${data[index].id}");
                                         await readGglAuth.downloadGoogleDriveFile("${data[index].id}", "${data[index].name}");
                                       },
                                       borderRadius: BorderRadius.circular(12),
                                       child: Container(
                                         height: 30,
                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                         decoration: BoxDecoration(
                                           color: Colors.orangeAccent.withOpacity(0.8),
                                           borderRadius: BorderRadius.circular(6),
                                         ),
                                         child: Center(
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text("${data[index].name}"),
                                               Icon(Icons.download_rounded),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ) ;
                              },
                            ),
                          ),
                        );
                      }else {
                        return const Center(
                          child: Text(
                              "Yükleniyor ...",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },

                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}