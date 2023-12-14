import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../riverpod_management.dart';

class CheckUserDelete extends ConsumerStatefulWidget {
  const CheckUserDelete({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckUserDelete> createState() => _checkUserDelete();
}

class _checkUserDelete extends ConsumerState<CheckUserDelete> {
  bool clicked = false ;
  bool cancelled = false ;
  int countdown = 3;
  late Timer _timer;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var readGglAuth = ref.read(gglDriveRiverpod);
    return WillPopScope(
      onWillPop: () async{
        if(_timer.isActive){
          _timer.cancel();
        }
        return false;
      },
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VERİLERİMİ SİL",
                      style: TextStyle(
                        color: Theme.of(context).dialogBackgroundColor,
                        fontFamily: 'Nexa4',
                        fontWeight: FontWeight.w900,
                        height: 1,
                        fontSize: 22,
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _timer.cancel();
                            Navigator.of(context).pop();
                          },
                          icon: Image.asset(
                            "assets/icons/remove.png",
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Hesabınıza ait Harcama verileri hariç bütün veriler kalıcı olarak silinecektir. "
                "Onaylıyor musunuz? (Yeniden aynı Email ile hesap oluşturabileceksiniz.)",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFE9E9E9),
                  fontFamily: "Nexa3"
                ),
              ),
              !clicked
              ? GestureDetector(
                onTap: () async {
                  setState(() {
                    clicked = true ;
                  });
                  print("Hesap silme işelemi başlatıldı.");
                  await startCountdown(readGglAuth);
                  print("Hesap silme işlemi bitti.");
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration:BoxDecoration(
                    color: Color(0xFF0D1C26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.8),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(-1, 2),
                  )
                ] ,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: Theme
                        .of(context)
                        .indicatorColor, // Set border color
                    width: 1.0),
                //color: Theme.of(context).primaryColor,
              ),
                  child: const Center(
                    child: Text(
                      "Hesabımı Sil",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              :Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children:[
                      CircularProgressIndicator(
                        color: Theme.of(context).disabledColor,
                        backgroundColor: Theme.of(context).disabledColor,
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Text(
                          countdown.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFE9E9E9),
                              fontFamily: "Nexa3"
                          ),
                        ),
                      )
                    ]
                  ),
                  GestureDetector(
                    onTap: () {
                      _timer.cancel();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 35,
                          color:  Color(0xFF1C2B35),
                          ),
                          Text(
                            "iptal et",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF0D1C26),
                                fontFamily: "Nexa3"
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> startCountdown(var readGglAuth) async {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      if(mounted){
        if (countdown > 0)  {
          setState(() {
            --countdown;
          });
        } else  {
          _timer.cancel();
          await readGglAuth.deleteUserData();
          await readGglAuth.signOutWithGoogle();
          readGglAuth.setAccountStatus(false);
          if(!cancelled){
            Navigator.of(context).pop();
          }
        }
      }
    });
  }

}
