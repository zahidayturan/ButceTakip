import 'package:flutter/material.dart';

class bkaSlider extends StatefulWidget {
  const bkaSlider({Key? key}) : super(key: key);

  @override
  State<bkaSlider> createState() => _bkaSliderState();
}

class _bkaSliderState extends State<bkaSlider> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/image/icon_BKA/LOGOBKA-4.png"
                ),
                Text("Bütçe Takip Uygulamamıza Hoşgeldiniz."),
                Text("Efendim cebinizde kaç TL vardı acaba bizimle paylaşır mısınız."),
                TextField(
                  controller: _controller,
                ),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                  },
                  child: Text("Vermiyorum kardeşim kan benim damar benim")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
