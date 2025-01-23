// to convert the response into a non nullable object (model)
import 'package:flutter_advance_course/app/extenstion.dart';
import 'package:flutter_advance_course/data/responses/responses.dart';
import 'package:flutter_advance_course/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(this?.phone?.orEmpty() ?? EMPTY,
        this?.link?.orEmpty() ?? EMPTY, this?.email?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contact?.toDomain());
  }
}
