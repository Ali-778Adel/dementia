import 'package:dartz/dartz.dart';

abstract class Failure{}

class InternetConnectionFailure extends Failure{

}

class UnStableInternetConnectionFailure extends Failure{

}

class EmptyCacheFailure extends Failure{

}

class ServerErrorFailure extends Failure{

}
