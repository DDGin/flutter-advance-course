import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      : message = message ?? AppStrings.loading.tr();

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

// Success
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
      {required BuildContext context,
      required Widget contentScreenWidget,
      required Function retryActionFunction,
      required Function resetFlowState}) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
          // showing popup dialog
          showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              resetFlowState: resetFlowState);
          // return the content ui of the content
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              resetFlowState: resetFlowState);
        }
      case SuccessState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
          // showing popup dialog
          showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              resetFlowState: resetFlowState);
          // return the content ui of the content
        } else {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            resetFlowState: resetFlowState,
            message: getMessage(),
            title: AppStrings.success.tr(),
          );
        }

      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            // showing popup dialog
            showPopUp(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                resetFlowState: resetFlowState);
            // return the content ui of the screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              resetFlowState: resetFlowState,
            );
          }
        }
      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;
      case EmptyState:
        return contentScreenWidget;
      default:
        return contentScreenWidget;
    }
    return Container();
  }

  // ìf it is main screen (top-most route), isCurrent return true
  // else it is a dialog (other route), isCurrent return false
  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(
      {required BuildContext context,
      required StateRendererType stateRendererType,
      String? message,
      String? title,
      required Function resetFlowState}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: () {},
              resetFlowState: resetFlowState),
        ));
  }
}
