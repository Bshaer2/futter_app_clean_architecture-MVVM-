import 'dart:async';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/base_view_model/base_view_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _sliderObjectList;

  int _sliderCurrentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _sliderObjectList = _getSliderObjectList();
    _postDataToView();
  }

  @override
  int showNextSliderPage() {
    int nextSliderPageIndex = ++_sliderCurrentIndex;
    if (nextSliderPageIndex == _sliderObjectList.length) {
      nextSliderPageIndex = 0;
    }
    return nextSliderPageIndex;
  }

  @override
  int showPreviousSliderPage() {
    int previousSliderPageIndex = --_sliderCurrentIndex;
    if (previousSliderPageIndex == Constants.minusOne) {
      previousSliderPageIndex = _sliderObjectList.length - 1;
    }
    return previousSliderPageIndex;
  }

  @override
  void onPageChanged(int index) {
    _sliderCurrentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream <SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: _sliderObjectList[_sliderCurrentIndex],
        numberOfSlides: _sliderObjectList.length,
        currentSliderObjectIndex: _sliderCurrentIndex));
  }

  List<SliderObject> _getSliderObjectList() => [
        SliderObject(
            title: StringsManager.onBoardingTitle1,
            subTitle: StringsManager.onBoardingSubTitle1,
            image: ImageManager.onboardingLogo1),
        SliderObject(
            title: StringsManager.onBoardingTitle2,
            subTitle: StringsManager.onBoardingSubTitle2,
            image: ImageManager.onboardingLogo2),
        SliderObject(
            title: StringsManager.onBoardingTitle3,
            subTitle: StringsManager.onBoardingSubTitle3,
            image: ImageManager.onboardingLogo3),
        SliderObject(
            title: StringsManager.onBoardingTitle4,
            subTitle: StringsManager.onBoardingSubTitle4,
            image: ImageManager.onboardingLogo4),
      ];
}

abstract mixin class OnboardingViewModelInputs {
  int showNextSliderPage();

  int showPreviousSliderPage();

  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract mixin class OnboardingViewModelOutputs {
  Stream <SliderViewObject> get outputSliderViewObject;
}
