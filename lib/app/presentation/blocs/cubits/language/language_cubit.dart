import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('ru')));

  void changeLanguage(Locale locale) {
    emit(LanguageState(locale));
  }
}
