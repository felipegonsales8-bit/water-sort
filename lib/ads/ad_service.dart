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

  /// Retorna true somente se o callback confirmar que a recompensa foi ganha.
  Future<bool> showRewarded() async {
    final ad = _rewardedAd;
    if (ad == null) {
      loadRewarded();
      return false;
    }

    _rewardedAd = null;
    var earnedReward = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (closedAd) {
        closedAd.dispose();
        loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (failedAd, _) {
        failedAd.dispose();
        loadRewarded();
      },
    );

    await ad.show(
      onUserEarnedReward: (_, __) {
        earnedReward = true;
      },
    );
    return earnedReward;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
