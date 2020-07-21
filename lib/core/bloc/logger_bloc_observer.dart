import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate_starter/core/log/logger.dart';

class LoggerBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Logger.debug('BLoC $bloc Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.debug('$transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Logger.error(
      '$bloc',
      Exception(error.toString()),
      stacktrace,
    );
  }
}
