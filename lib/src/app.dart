import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wallet_task/src/cubit/theme/theme_cubit.dart';
import 'package:wallet_task/src/pages/login_screen.dart';
import 'package:wallet_task/src/utils/app_localization.dart';
import 'package:wallet_task/src/utils/dependency_injection.dart';

import 'cubit/languageCubit/language_cubit.dart';
import 'cubit/signInCubit/sign_in_cubit.dart';
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
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              // ThemeState contains the current theme (light or dark)
              return MaterialApp(
                theme: themeState.themeData, // Apply the dynamic theme here
                locale: languageState is LanguageChangeState
                    ? Locale(languageState.languageCode!)
                    : const Locale(
                        'en'), // Default to English if no language state
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
                          return locale; // Return the matching locale
                        }
                      }
                    }
                  }
                  return supportedLocales
                      .first; // Fallback to the first supported locale
                },
                home: BlocProvider(
                  create: (context) => getIt<SignInCubit>(),
                  child: LoginScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
