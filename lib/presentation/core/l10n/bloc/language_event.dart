part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageLoadStarted extends LanguageEvent {}

class LanguageSelected extends LanguageEvent {
  final String languageCode;

  LanguageSelected(this.languageCode) : assert(languageCode != null);

  @override
  List<Object> get props => [languageCode];
}
