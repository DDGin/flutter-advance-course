import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// Loading(POPUP, FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(this.stateRendererType, String? message)
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTYSTR;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

// Empty
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}
