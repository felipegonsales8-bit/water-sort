import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:watersort/ads/ad_service.dart';

import 'package:watersort/data/services/hive_service.dart';
import 'package:watersort/ui/core/theme/app_theme.dart';
import 'package:watersort/ui/providers.dart';
import 'package:watersort/ui/features/home/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o SDK de anúncios; o manifesto ainda usa o App ID oficial de teste.
  await MobileAds.instance.initialize();
  AdService.instance.loadRewarded();

  final hiveService = HiveService();
  await hiveService.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(
    ProviderScope(
      overrides: [
        hiveServiceProvider.overrideWithValue(hiveService),
      ],
      child: const WaterSortApp(),
    ),
  );
}

class WaterSortApp extends StatelessWidget {
  const WaterSortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potion Master',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
