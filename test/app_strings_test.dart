import 'package:flutter_test/flutter_test.dart';
import 'package:watersort/app_strings.dart';

void main() {
  group('Potion Master localization', () {
    test('Portuguese is available for the main game actions', () {
      expect(AppStrings.t('start_game', 'pt'), 'COMEÇAR');
      expect(AppStrings.t('game_modes', 'pt'), 'MODOS DE JOGO');
      expect(AppStrings.t('settings', 'pt'), 'CONFIGURAÇÕES');
    });

    test('English and Spanish translations are available', () {
      expect(AppStrings.t('start_game', 'en'), 'START GAME');
      expect(AppStrings.t('start_game', 'es'), 'EMPEZAR');
    });

    test('unknown language falls back to English', () {
      expect(AppStrings.t('hint', 'fr'), 'HINT • AD');
    });
  });
}
