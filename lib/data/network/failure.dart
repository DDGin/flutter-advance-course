import 'package:flutter_advance_course/data/network/error_handler.dart';

class Failure {
  int code; // 200 or 400
/*
HTTP response
200s – Success: The request has been received and works well.
400s – Client error: The request has been asked by a client
but the destination page is not correct.
*/
  String message; // error or success

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
