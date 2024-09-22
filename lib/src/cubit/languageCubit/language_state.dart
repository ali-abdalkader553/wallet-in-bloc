part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitialState extends LanguageState {}

final class LanguageChangeState extends LanguageState {
  final String? languageCode;
  bool isEnglish;

  LanguageChangeState({required this.languageCode, required this.isEnglish});
}
