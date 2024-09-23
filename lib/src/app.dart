import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wallet_task/src/pages/home_page.dart';
import 'package:wallet_task/src/utils/app_localization.dart';
import 'package:wallet_task/src/utils/constants.dart';
import 'package:wallet_task/src/utils/dependency_injection.dart';

import 'cubit/languageCubit/language_cubit.dart';
import 'cubit/signInCubit/sign_in_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'data/models/language_model.dart';

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit()
            ..changelanguage(LanguageEventsenum.InitialLanguage),
        ),
        BlocProvider(create: (context) => ThemeCubit()), // Provide ThemeCubit
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          if (languageState is LanguageChangeState) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  theme: themeState.themeData,
                  locale: Locale(languageState.languageCode!),
                  supportedLocales: const [Locale('ar'), Locale('en')],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  localeListResolutionCallback:
                      (deviceLocales, supportedLocales) {
                    if (deviceLocales != null) {
                      for (var deviceLocale in deviceLocales) {
                        for (var locale in supportedLocales) {
                          if (deviceLocale.languageCode ==
                              locale.languageCode) {
                            return locale;
                          }
                        }
                      }
                    }
                    return supportedLocales.first;
                  },
                  home: BlocProvider(
                    create: (context) => getIt<SignInCubit>(),
                    child: HomePage(),
                  ),
                );
              },
            );
          }
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                theme: themeState.themeData,
                supportedLocales: const [Locale('ar'), Locale('en')],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeListResolutionCallback:
                    (deviceLocales, supportedLocales) {
                  if (deviceLocales != null) {
                    for (var deviceLocale in deviceLocales) {
                      for (var locale in supportedLocales) {
                        if (deviceLocale.languageCode == locale.languageCode) {
                          // Check if the language is Arabic
                          if (locale.languageCode == 'ar') {
                            isEnglish = true;
                          } else {
                            isEnglish = false;
                          }

                          // Return the matched locale
                          return locale;
                        }
                      }
                    }
                  }

                  // Return default supported locale if no match is found
                  return supportedLocales.first;
                },
                home: BlocProvider(
                  create: (context) => getIt<SignInCubit>(),
                  child: HomePage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
