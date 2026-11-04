import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watersort/ui/core/theme/app_colors.dart';

void main() {
  group('Potion Master alchemy theme', () {
    test('alchemy is the default theme', () {
      expect(AppColors.activeTheme, ThemePack.alchemy);
    });

    test('alchemy palette uses the intended dark fantasy background', () {
      AppColors.setTheme(ThemePack.alchemy);
      expect(AppColors.bg, const Color(0xFF17111F));
      expect(AppColors.accent, const Color(0xFFC69A4A));
    });

    test('theme can switch and return to alchemy', () {
      AppColors.setTheme(ThemePack.forest);
      expect(AppColors.activeTheme, ThemePack.forest);

      AppColors.setTheme(ThemePack.alchemy);
      expect(AppColors.activeTheme, ThemePack.alchemy);
    });
  });
}
