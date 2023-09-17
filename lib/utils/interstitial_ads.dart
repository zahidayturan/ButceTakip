import 'package:butcekontrol/utils/ads_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId, /// YOUR INTERSTITIAL AD ID Android Test : ca-app-pub-3940256099942544/1033173712
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd(BuildContext context) {
    if (_isAdLoaded) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          //Navigator.of(context).pop();
          _interstitialAd!.dispose();
          _isAdLoaded = false;
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('InterstitialAd failed to show: $error');
          _interstitialAd!.dispose();
          _isAdLoaded = false;
        },
      );

      _interstitialAd!.show();
    } else {
      // not ad
    }
  }
}