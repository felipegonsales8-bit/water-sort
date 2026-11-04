import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Google test ad units are used until the developer supplies their own AdMob IDs.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  static const String _rewardedTestUnitId =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _interstitialTestUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;
  bool _isLoadingRewarded = false;
  bool _isLoadingInterstitial = false;
  int _completedLevelTransitions = 0;

  bool get isRewardedReady => _rewardedAd != null;

  void loadRewarded() {
    if (_isLoadingRewarded || _rewardedAd != null) return;
    _isLoadingRewarded = true;

    RewardedAd.load(
      adUnitId: _rewardedTestUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoadingRewarded = false;
        },
        onAdFailedToLoad: (_) {
          _rewardedAd = null;
          _isLoadingRewarded = false;
        },
      ),
    );
  }

  void loadInterstitial() {
    if (_isLoadingInterstitial || _interstitialAd != null) return;
    _isLoadingInterstitial = true;

    InterstitialAd.load(
      adUnitId: _interstitialTestUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoadingInterstitial = false;
        },
        onAdFailedToLoad: (_) {
          _interstitialAd = null;
          _isLoadingInterstitial = false;
        },
      ),
    );
  }

  /// Returns true only after the SDK confirms the reward callback.
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

  /// Show an interstitial only on every third completed-level transition.
  /// If no ad is ready, the game continues without blocking the player.
  Future<void> showInterstitialIfDue() async {
    _completedLevelTransitions++;
    if (_completedLevelTransitions % 3 != 0) {
      loadInterstitial();
      return;
    }

    final ad = _interstitialAd;
    if (ad == null) {
      loadInterstitial();
      return;
    }

    _interstitialAd = null;
    final result = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (closedAd) {
        closedAd.dispose();
        if (!result.isCompleted) result.complete();
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (failedAd, _) {
        failedAd.dispose();
        if (!result.isCompleted) result.complete();
        loadInterstitial();
      },
    );
    ad.show();
    await result.future;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd = null;
    _interstitialAd = null;
  }
}
