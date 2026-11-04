import 'package:flutter/material.dart';
import 'package:watersort/ui/core/theme/app_colors.dart';
import 'package:watersort/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watersort/ui/providers.dart';
import 'package:watersort/ui/core/widgets/tangible_button.dart';

class HowToPlayView extends ConsumerWidget {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(homeViewModelProvider).language;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C22), // Off-black
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF222222), // charcoal
                          width: 1.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppStrings.t('how_to_play_title', language),
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppColors.headingWhite,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 44), // Balancer for leading back button
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _step(
                      1,
                      AppStrings.t('step_select_tube', language),
                      AppStrings.t('step_select_tube_desc', language),
                      Icons.touch_app_rounded,
                      language,
                    ),
                    const SizedBox(height: 16),
                    _step(
                      2,
                      AppStrings.t('step_pour', language),
                      AppStrings.t('step_pour_desc', language),
                      Icons.water_drop_rounded,
                      language,
                    ),
                    const SizedBox(height: 16),
                    _step(
                      3,
                      AppStrings.t('step_sort', language),
                      AppStrings.t('step_sort_desc', language),
                      Icons.done_all_rounded,
                      language,
                    ),
                    const SizedBox(height: 16),
                    _step(
                      4,
                      AppStrings.t('step_symbols', language),
                      AppStrings.t('step_symbols_desc', language),
                      Icons.accessibility_new_rounded,
                      language,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Got It button at the bottom (Primary CTA)
            Padding(
              padding: const EdgeInsets.all(24),
              child: TangibleButton(
                text: AppStrings.t('got_it', language),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(int num, String title, String desc, IconData icon, String language) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181818), // Dark charcoal background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF222222), // ultra-faint borders
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number container with lime green borders
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.accent, // Lime Green (#86EF4D)
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.15),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(child: Icon(icon, color: AppColors.accent, size: 20)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${language == 'pt' ? 'ETAPA' : language == 'es' ? 'PASO' : 'STEP'} $num',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accent,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headingWhite,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 15,
                    color: AppColors.subtext,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
