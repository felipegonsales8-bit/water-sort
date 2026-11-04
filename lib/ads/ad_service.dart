import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Serviço de anúncios recompensados.
/// O bloco abaixo é o ID oficial de teste do Google. Substitua pelo seu
/// próprio ID do AdMob antes de publicar o aplicativo.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  static const String _rewardedTestUnitId =
      'ca-app-pub-3940256099942544/5224354917';

  RewardedAd? _rewardedAd;
  bool _isLoading = false;

  bool get isRewardedReady => _rewardedAd != null;

  void loadRewarded() {
    if (_isLoading || _rewardedAd != null) return;
    _isLoading = true;

    RewardedAd.load(
      adUnitId: _rewardedTestUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (_) {
          _rewardedAd = null;
          _isLoading = false;
        },
      ),
    );
  }

  /// Aguarda o fechamento do anúncio e retorna true apenas se a recompensa
  /// tiver sido confirmada pelo callback oficial do SDK.
  Future<bool> showRewarded() {
    final ad = _rewardedAd;
    if (ad == null) {
      loadRewarded();
      return Future.value(false);
    }

    _rewardedAd = null;
    final result = Completer<bool>();
    var earnedReward = false;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (closedAd) {
        closedAd.dispose();
        if (!result.isCompleted) result.complete(earnedReward);
        loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (failedAd, _) {
        failedAd.dispose();
        if (!result.isCompleted) result.complete(false);
        loadRewarded();
      },
    );

    ad.show(
      onUserEarnedReward: (_, __) {
        earnedReward = true;
      },
    );

    return result.future;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
