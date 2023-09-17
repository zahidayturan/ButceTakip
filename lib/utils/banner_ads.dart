import 'package:butcekontrol/utils/ads_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class BannerAds extends StatefulWidget {
  final AdSize adSize;
  const BannerAds({required this.adSize, Key? key}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAds();
}

class _BannerAds extends State<BannerAds> {

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }
  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId, /// YOUR BANNER AD ID Android Test : ca-app-pub-3940256099942544/6300978111
      request: const AdRequest(),
      size: widget.adSize,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    if (_isBannerAdReady) {
      return  Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
      );
    }
    else {
      return const SizedBox();
    }
  }
}