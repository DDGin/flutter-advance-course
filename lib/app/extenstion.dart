// extension on String
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:rxdart/rxdart.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return EMPTYSTR;
    } else {
      return this!;
    }
  }
}

// extension on Integer
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return ZERO;
    } else {
      return this!;
    }
  }
}

// https://stackoverflow.com/questions/55536461/flutter-unhandled-exception-bad-state-cannot-add-new-events-after-calling-clo
extension BehaviorSubjectExtensions<T> on BehaviorSubject<T> {
  set safeValue(T newValue) => isClosed == false ? add(newValue) : () {};
}
