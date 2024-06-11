import 'failure.dart';

class LocationPermissionError extends Failure {
  LocationPermissionError({required super.message});
}

class LocationNotEnabled extends Failure {
  LocationNotEnabled({required super.message});
}

class LocationFetchingError extends Failure {
  LocationFetchingError({required super.message});
}

class LocationTooFar extends Failure {
  LocationTooFar({required super.message});
}
