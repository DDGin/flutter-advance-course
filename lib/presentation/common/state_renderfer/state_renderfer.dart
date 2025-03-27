import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/data/network/failure.dart';
import 'package:flutter_advance_course/presentation/resources/asset_manager.dart';
import 'package:flutter_advance_course/presentation/resources/color_manager.dart';
import 'package:flutter_advance_course/presentation/resources/font_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/style_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  // FULL SCREEN STATE
  FULL_SCREEN_LOADING_PAGE,
  FULL_SCREEN_ERROR_PAGE,

  // THE UI OF THE SCREEN
  CONTENT_SCREEN_STATE,

  // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
  EMPTY_SCREEN_STATE
}

class StateRenderfer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  // TODO: Why isn't need required here
  StateRenderfer(Key? key, this.stateRendererType, Failure? failure,
      String? message, String? title, this.retryActionFunction)
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTYSTR,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDiaLog(
            context, [_getAnimatedImage(JsonAssets.loadingAni)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDiaLog(context, [
          _getAnimatedImage(JsonAssets.errorAni),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
        break;
      case StateRendererType.FULL_SCREEN_LOADING_PAGE:
        _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.loadingAni), _getMessage(message)]);
        break;
      case StateRendererType.FULL_SCREEN_ERROR_PAGE:
        _getItemsInColumn([
          _getAnimatedImage(JsonAssets.errorAni),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
        break;
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.emptyAni), _getMessage(message)]);
    }
    return Container();
  }

  Widget _getAnimatedImage(String Ani) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      // json image
      child: Lottie.asset(Ani),
    );
  }

  Widget _getPopUpDiaLog(BuildContext context, List<Widget> children) {
    return Dialog(
      child: Container(
        child: _getDiaLogContent(context, children),
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s12,
                  offset: Offset(AppSize.s0, AppSize.s12))
            ]),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _getDiaLogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s100,
          height: AppSize.s100,
          // message
          child: Text(
            message,
            style: getMediumStyle(
                color: ColorManager.black, fontSize: FontSize.s16),
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: ElevatedButton(
            onPressed: () {
              if (stateRendererType ==
                  StateRendererType.FULL_SCREEN_ERROR_PAGE) {
                // Call the API function again to retry
                retryActionFunction?.call();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle)),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
