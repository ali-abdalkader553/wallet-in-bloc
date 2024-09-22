import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/language_model.dart';
import '../../utils/constants.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitialState());

  changelanguage(LanguageEventsenum eventType) {
    print("test");
    switch (eventType) {
      case LanguageEventsenum.InitialLanguage:
        print("test E");

        if (sharedPreferences!.getString('lang') != null) {
          print("test 1");

          if (sharedPreferences!.getString('lang') == 'ar') {
            print("test2");

            emit(LanguageChangeState(languageCode: 'ar', isEnglish: true));
          } else {
            print("test3");

            emit(LanguageChangeState(languageCode: 'en', isEnglish: false));
          }
        }
        break;

      case LanguageEventsenum.ArabicLanguage:
        print("test A");

        sharedPreferences!.setString('lang', 'ar');
        emit(LanguageChangeState(languageCode: 'ar', isEnglish: true));
        break;

      case LanguageEventsenum.EnglishLanguage:
        print("test E");

        sharedPreferences!.setString('lang', 'en');
        emit(LanguageChangeState(languageCode: 'en', isEnglish: false));
        break;
    }
  }
}
