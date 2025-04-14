import 'dart:async';
import 'dart:developer';

import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/usecase/home_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/home_usecase.dart';

class HomeViewModel extends BaseViewModel {
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
}
