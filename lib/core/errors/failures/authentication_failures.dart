import 'failure.dart';

class PassNotMatchedConfPass extends Failure {
  const PassNotMatchedConfPass() : super('PassNotMatchedConfPass');
}

class EmailAlreadyExist extends Failure {
  const EmailAlreadyExist() : super('EmailAlreadyExist');
}

class WeekPassword extends Failure {
  const WeekPassword() : super('WeekPassword');
}

class InvalidEmail extends Failure {
  const InvalidEmail() : super('InvalidEmail');
}

class EmailAndPasswordNotMatched extends Failure {
  const EmailAndPasswordNotMatched() : super('EmailAndPasswordNotMatched');
}
