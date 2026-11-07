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

    test('game and settings labels exist in all supported languages', () {
      const keys = [
        'retry', 'undo', 'random_level', 'time_up', 'time_up_description',
        'try_again', 'super_hard', 'super_hard_description',
        'undo_decrement', 'undo_decrement_description', 'backup_restore',
        'export_backup', 'import_backup', 'support_about',
        'reset_all_progress', 'reset_progress_title', 'reset_progress_body',
      ];
      for (final language in ['pt', 'en', 'es']) {
        for (final key in keys) {
          expect(AppStrings.t(key, language), isNot(key),
              reason: 'Missing $key translation for $language');
        }
      }
    });

    test('unknown language falls back to English', () {
      expect(AppStrings.t('hint', 'fr'), 'HINT • AD');
    });
  });
}
