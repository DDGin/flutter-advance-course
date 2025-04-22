import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/usecase/home_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  BehaviorSubject<HomeData> _dataStreamController = BehaviorSubject<HomeData>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(
        LoadingState(StateRendererType.FULL_SCREEN_LOADING_PAGE, EMPTYSTR));
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_PAGE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputHomeData.add(HomeData(homeObject.data.services,
          homeObject.data.banners, homeObject.data.stores));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  // ------ input ------
  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // ------ output ------
  @override
  Stream<HomeData> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract mixin class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract mixin class HomeViewModelOutputs {
  Stream<HomeData> get outputHomeData;
}
