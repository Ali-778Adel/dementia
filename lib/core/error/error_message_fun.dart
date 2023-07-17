
import 'contstant_error_messages.dart';
import 'failures.dart';

String getErrorMessage(Failure failure){
  switch (failure.runtimeType){
    case InternetConnectionFailure:{
      return internetFailureMessage;
    }
    case ServerErrorFailure:{
      return serverErrorFailureMessage;
    }
    case EmptyCacheFailure:{
      return emptyCacheFailureMessage;
    }
    default :{
      return 'un expected error';
    }
  }

}