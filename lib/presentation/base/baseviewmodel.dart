// Use implements and you must to use all methods
// Or change abstract to mixin to use
abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model.
}

/*abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and functions that will be used through any view model.
}*/

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when view model dies.
}

abstract class BaseViewModelOutputs {}

/*
Mixins and mixin classes cannot have an extends clause,
and must not declare any generative constructors
*/
/*mixin class BaseViewModelOutputs {}*/
