import 'package:bloc/bloc.dart' show Cubit;
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: ThemeData.light()));

  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    emit(ThemeState(themeData: isDark ? ThemeData.dark() : ThemeData.light()));
  }
}
