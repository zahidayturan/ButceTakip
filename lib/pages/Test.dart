import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class testPage extends StatelessWidget {
  const testPage({Key? key}) : super(key: key);

  fetchExchangeRates()  async {
    const String apiBaseUrl = 'https://api.exchangeratesapi.io';
    const String endpoint = '/latest';
    const String apiKey = 'd6a35d6d178c2cb4e7a6b5305b50f396';
    final response = await http.get(Uri.parse("https://api.apilayer.com/exchangerates_data/latest?base=USD&symbols=TRY,EUR,GBP,KWD"),
    headers: {
      "apikey" : "bYRgW5gWlBEvjYgFnxLZs9Gdl5twQLtN"
    });

    if(response.statusCode == 200){
      //başarılı
      print("geldi");
      response.body;
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      print("***********************");
      print(responseMap);
      print("TL => ${responseMap["rates"]["USD"]}");
    }else if (response.statusCode == 104){
      //Aylık istenilen max isteğe ulaşıldı
      print("c");
    }else{
      print("b");
      print(response.statusCode);
      //başarısız
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  fetchExchangeRates();
                },
                child: Text("AYYHH")
            )
          ],
        ),
      ),
    );
  }
}
