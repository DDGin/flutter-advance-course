// Use implements and you must to use all methods
// Or change abstract to mixin to use
import 'dart:async';
import 'dart:developer';

import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // BaseViewModel is an intermediate class of BVMInputs, BVMOutputs
  // I think so :)
  final StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

  void resetFlowState() {
    inputState.add(ContentState());
  }
// shared variables and functions that will be used through any view model.
}

abstract mixin class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when view model dies.

  Sink get inputState;
}

abstract mixin class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

/*
Mixins and mixin classes cannot have an extends clause,
and must not declare any generative constructors
*/
/*mixin class BaseViewModelOutputs {}*/
