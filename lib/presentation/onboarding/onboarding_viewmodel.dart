import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:flutter_advance_course/presentation/resources/asset_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

class OnBoardingViewModel
    implements
        BaseViewModel,
        OnBoardingViewModelInputs,
        OnBoardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onboardingLogo4),
      ];

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _list.length - 1) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    _postDataToView();

    return _currentIndex;
  }

  @override
  int goPrevious() {
    // TODO: implement goPrevious
    int previousIndex = _currentIndex--; // -1
    if (previousIndex <= 0) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    _postDataToView();

    return _currentIndex;
  }

  @override
  void onPageChange(int index) {
    // TODO: implement onPageChange
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  _postDataToView() {
    inputSliderViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  @override
  // TODO: implement inputState
  Sink get inputState => throw UnimplementedError();

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => throw UnimplementedError();

  @override
  void resetFlowState() {
    // TODO: implement resetFlowState
  }
}

// inputs mean the orders that out view model will receive from out view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left

  void goPrevious(); // when user clicks on right arrow or swipe right

  void onPageChange(int index);

  Sink get inputSliderViewObject; // this is the way to add data to stream
}

// outputs mean data or results that will be sent from out view model to out view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
