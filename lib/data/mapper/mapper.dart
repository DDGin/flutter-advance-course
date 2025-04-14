// to convert the response into a non nullable object (model)
import 'package:flutter_advance_course/app/extenstion.dart';
import 'package:flutter_advance_course/data/responses/responses.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/usecase/forgot_password_usecase.dart';

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

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTYSTR;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO,
        this?.title?.orEmpty() ?? EMPTYSTR, this?.image?.orEmpty() ?? EMPTYSTR);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTYSTR,
        this?.image?.orEmpty() ?? EMPTYSTR);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAD toDomain() {
    return BannerAD(
        this?.id?.orZero() ?? ZERO,
        this?.link?.orEmpty() ?? EMPTYSTR,
        this?.title?.orEmpty() ?? EMPTYSTR,
        this?.image?.orEmpty() ?? EMPTYSTR);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mapperServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Service>()
            .toList();

    List<Store> mapperStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                Iterable.empty())
            .cast<Store>()
            .toList();

    List<BannerAD> mapperBanners =
        (this?.data?.banners?.map((banner) => banner.toDomain()) ??
                Iterable.empty())
            .cast<BannerAD>()
            .toList();

    var data = HomeData(mapperServices, mapperBanners, mapperStores);

    return HomeObject(data);
  }
}
