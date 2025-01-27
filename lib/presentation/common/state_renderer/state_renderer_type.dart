import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

import '../../resources/strings_manager.dart';

enum StateRendererType {
  popUpErrorStateRenderer,
  popUpLoadingStateRenderer,
  popUpSuccess,
  fullScreenErrorStateRenderer,
  fullScreenLoadingStateRenderer,
  fullScreenEmptyStateRenderer,
  contentStateRenderer
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;

  const StateRenderer(
      {super.key,
      required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingStateRenderer:
        return _getPopUpDialog(
            context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popUpErrorStateRenderer:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.fullScreenLoadingStateRenderer:
        return _getItemsColumn(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorStateRenderer:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case StateRendererType.fullScreenEmptyStateRenderer:
        return _getItemsColumn(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      case StateRendererType.contentStateRenderer:
        return Container();
      case StateRendererType.popUpSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size14)),
      elevation: AppSize.size1,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.size14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height: AppSize.size100,
        width: AppSize.size100,
        child: Lottie.asset(animationName));
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding8),
        child: Text(
          message,
          style:
              TextStyle(color: ColorManager.black, fontSize: FontSize.size18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRendererType ==
                          StateRendererType.fullScreenErrorStateRenderer) {
                    // call retry function
                    retryActionFunction.call();
                  } else {
                    if(stateRendererType == StateRendererType.popUpErrorStateRenderer) {
                      // popup error state
                    Navigator.of(context, rootNavigator: true).pop(true);
                    }                  }
                },
                child: Text(buttonTitle))),
      ),
    );
  }
}
