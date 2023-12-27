import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String? get errorResponse;
}

class FailedResponse extends Failure {
  final String? error;
  FailedResponse({this.error});

  @override
  String? get errorResponse => error;

  @override
  List<Object?> get props => [error];
}