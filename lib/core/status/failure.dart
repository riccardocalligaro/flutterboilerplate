import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String errorMessage;

  Failure({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// General failures
class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure({this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

class DatabaseFailure extends Failure {}

class GenericFailure extends Failure {}

class NotConnectedFailure extends Failure {}

class LocationServicesNotAvailableFailure extends Failure {}

//class LocationServicesNotAvailable implements Exception {
//  String errorMessage() {
//    return 'User has location services disabled';
//  }
//}

class NotConntectedException implements Exception {
  String errorMessage() {
    return 'User is not conntected to the internet';
  }
}
