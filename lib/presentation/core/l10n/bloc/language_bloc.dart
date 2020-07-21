import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../shared_prefs_service.dart';

part 'language_event.dart';
part 'language_state.dart';

/// BloC che si occupa della localizzazione
/// Si puó cambiare lo stato tramite i due eventi
/// - [LanguageLoadStarted] che viene triggerato ogni volta che l'applicazione
/// viene aperta
///
/// - [LanguageLoadSelected] che si puo chiamare per cambiare la lingua (Gli si passa il Lanuage.IT ad esempio)
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageState initialState)
      : super(LanguageState(Locale('en', 'US')));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.languageCode);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;

    final defaultLanguageCode = sharedPrefService.languageCode;

    Locale locale;

    if (defaultLanguageCode == null) {
      locale = Locale('en', 'US');
      await sharedPrefService.setLanguage(locale.languageCode);
    } else {
      locale = Locale(defaultLanguageCode);
    }

    yield LanguageState(locale);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(
      String selectedLanguage) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final defaultLanguageCode = sharedPrefService.languageCode;

    // Nel caso la lingua fosse giá di default non la dobbiamo cambiare
    if (selectedLanguage == 'it' && defaultLanguageCode != 'it') {
      yield* _loadLanguage(sharedPrefService, 'it', 'IT');
    } else if (selectedLanguage == 'en' && defaultLanguageCode != 'en') {
      yield* _loadLanguage(sharedPrefService, 'en', 'US');
    }
  }

  /// Metodo per evitare ripetizione del codice
  Stream<LanguageState> _loadLanguage(
      SharedPreferencesService sharedPreferencesService,
      String languageCode,
      String countryCode) async* {
    final locale = Locale(languageCode, countryCode);
    await sharedPreferencesService.setLanguage(locale.languageCode);
    yield LanguageState(locale);
  }
}
