// to convert the response into a non nullable object (model)
import 'package:flutter_advance_course/app/extenstion.dart';
import 'package:flutter_advance_course/data/responses/responses.dart';
import 'package:flutter_advance_course/domain/model/model.dart';

const EMPTYSTR = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTYSTR,
        this?.name?.orEmpty() ?? EMPTYSTR,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(this?.phone?.orEmpty() ?? EMPTYSTR,
        this?.link?.orEmpty() ?? EMPTYSTR, this?.email?.orEmpty() ?? EMPTYSTR);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contact?.toDomain());
  }
}
