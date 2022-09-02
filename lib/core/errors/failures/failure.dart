import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message) : super();
  final String message;

  @override
  List<Object?> get props => [message];
}

class Unexpected extends Failure {
  const Unexpected({String message = 'Unexpected'}) : super(message);
}
