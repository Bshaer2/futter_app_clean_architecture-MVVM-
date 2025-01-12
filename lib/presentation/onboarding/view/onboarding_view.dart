import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

import '../../resources/constants_manager.dart';
import '../../resources/route_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _sliderPageController = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _buildScaffold(snapshot.data);
        });
  }

  Widget _buildScaffold(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: _buildAppBar(),
        body: _buildBody(sliderViewObject),
        bottomSheet: _bottomSheetSection(sliderViewObject),
      );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.white,
      elevation: AppSize.size0,
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark),
    );
  }

  PageView _buildBody(SliderViewObject sliderViewObject) {
    return PageView.builder(
      itemCount: sliderViewObject.numberOfSlides,
      controller: _sliderPageController,
      onPageChanged: (index) {
        _viewModel.onPageChanged(index);
      },
      itemBuilder: (context, index) {
        return OnBoardingPage(sliderViewObject.sliderObject);
      },
    );
  }

  Container _bottomSheetSection(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _bottomSheetColFirstSection(),
          SizedBox(
            height: AppSize.size8,
          ),
          _bottomSheetColSecondSection(sliderViewObject)
        ],
      ),
    );
  }

  Align _bottomSheetColFirstSection() {
    return Align(
      alignment: Alignment.centerRight,
      child: _textButtonOfBottomSheet(),
    );
  }

  TextButton _textButtonOfBottomSheet() {
    return TextButton(
      onPressed: _navigateToLoginView,
      child: _textButtonText(),
    );
  }

  void _navigateToLoginView() =>
      Navigator.pushReplacementNamed(context, Routes.loginRoute);

  Text _textButtonText() {
    return Text(
      AppStrings.skip,
      style: Theme.of(context).textTheme.labelSmall,
      textAlign: TextAlign.end,
    );
  }

  Container _bottomSheetColSecondSection(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primaryColor,
      child: _rowOfBottomSheetSecondSection(sliderViewObject),
    );
  }

  Row _rowOfBottomSheetSecondSection(SliderViewObject sliderViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(AppPadding.padding14),
          child: GestureDetector(
            onTap: _animateToPreviousSliderPage,
            child: _backArrowIcon(),
          ),
        ),
        Row(
          children: [
            for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
              Padding(
                padding: EdgeInsets.all(AppPadding.padding14),
                child: sliderViewObject.currentSliderObjectIndex == i
                    ? returnIcon(Icons.circle_outlined)
                    : returnIcon(Icons.circle_rounded),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.padding14),
          child: GestureDetector(
            onTap: _animateToNextSliderPage,
            child: SizedBox(
              width: AppSize.size20,
              height: AppSize.size20,
              child: Icon(Icons.arrow_forward_ios,
                  color: ColorManager.white, size: AppSize.size20),
            ),
          ),
        )
      ],
    );
  }

  Icon returnIcon(IconData? iconData) {
    return Icon(
      iconData,
      color: ColorManager.white,
      size: AppSize.size12,
    );
  }

  Icon _backArrowIcon() {
    return Icon(Icons.arrow_back_ios_new,
        color: ColorManager.white, size: AppSize.size20);
  }

  void _animateToPreviousSliderPage() {
    _sliderPageController.animateToPage(_viewModel.showPreviousSliderPage(),
        duration: Duration(milliseconds: Constants.animationSliderDuration),
        curve: Curves.bounceInOut);
  }

  void _animateToNextSliderPage() {
    _sliderPageController.animateToPage(_viewModel.showNextSliderPage(),
        duration: Duration(milliseconds: Constants.animationSliderDuration),
        curve: Curves.bounceInOut);
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppSize.size40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: AppSize.size8,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.subTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        SizedBox(
          height: AppSize.size60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
