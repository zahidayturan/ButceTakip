import 'package:butcekontrol/constans/material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../classes/language.dart';
import '../riverpod_management.dart';

class listBackUpPopUp extends ConsumerStatefulWidget{
  const listBackUpPopUp({Key? key}) : super(key: key);

  @override
  ConsumerState<listBackUpPopUp> createState() => _listBackUpPopUp();
}

class _listBackUpPopUp extends ConsumerState<listBackUpPopUp> {
  Future<List> ?backUpList  ;
  bool isclicked = false ;
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
                  padding: const EdgeInsets.all(15),
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
                        return Theme (
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                     InkWell(
                                       onTap:() async {
                                         print("${data[index].id}");
                                         setState(() {
                                           isclicked = true;
                                         });
                                         try{
                                           await readGglAuth.downloadGoogleDriveFile("${data[index].id}", "${data[index].name}").then((value) {
                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                             setState(() {
                                               isclicked = false ;
                                             });
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               SnackBar(
                                                 backgroundColor:
                                                 const Color(0xff0D1C26),
                                                 duration: const Duration(seconds: 2),
                                                 content: Text(
                                                   translation(context).dataRestoredFromGoogleDrive,
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
                                           });
                                         }catch(e){
                                           print("iki kez pop edildi $e");
                                         }
                                       },
                                       borderRadius: BorderRadius.circular(12),
                                       child: Container(
                                         height: 30,
                                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                         decoration: BoxDecoration(
                                           color: Colors.orangeAccent.withOpacity(0.8),
                                           borderRadius: BorderRadius.circular(6),
                                         ),
                                         child: Center(
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(!isclicked ? "${data[index].name}" : "Yükleniyor ..."),
                                               const Icon(Icons.download_rounded),
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