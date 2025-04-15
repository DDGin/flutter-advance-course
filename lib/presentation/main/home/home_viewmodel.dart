import 'dart:async';
import 'dart:developer';

import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/usecase/home_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/home_usecase.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  StreamController _servicesStreamController = BehaviorSubject<List<Service>>();
  StreamController _bannersStreamController = BehaviorSubject<List<BannerAD>>();
  StreamController _storesStreamController = BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  // ------ input ------
  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // ------ output ------
  @override
  Stream<List<BannerAD>> get outputBanners =>
      _bannersStreamController.stream.map((banner) => banner);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((service) => service);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((store) => store);
}

abstract mixin class HomeViewModelInputs {
  Sink get inputServices;

  Sink get inputStores;

  Sink get inputBanners;
}

abstract mixin class HomeViewModelOutputs {
  Stream<List<Service>> get outputServices;

  Stream<List<Store>> get outputStores;

  Stream<List<BannerAD>> get outputBanners;
}
