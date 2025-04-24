import 'dart:ffi';

import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/usecase/store_details_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  StoreDetailsUseCase _storeDetailsUseCase;

  BehaviorSubject<StoreDetails> _dataStreamController =
      BehaviorSubject<StoreDetails>();

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetails1();
  }

  _getStoreDetails1() async {
    inputState.add(
        LoadingState(StateRendererType.FULL_SCREEN_LOADING_PAGE, EMPTYSTR));
    (await _storeDetailsUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_PAGE, failure.message));
    }, (storeDetails) {
      inputState.add(ContentState());
      inputStoreDetails.add(storeDetails);
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _dataStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _dataStreamController.stream.map((storeDetails) => storeDetails);
}

abstract mixin class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract mixin class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
