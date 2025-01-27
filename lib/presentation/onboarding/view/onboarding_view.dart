import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
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
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnboardingScreenViewed();
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
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, Routes.loginRoute),
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.size8,
              ),
              Container(
                color: ColorManager.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppPadding.padding14),
                      child: GestureDetector(
                        onTap: _animateToPreviousSliderPage,
                        child: _backArrowIcon(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppPadding.padding14),
                      child: SmoothPageIndicator(
                        controller: _sliderPageController,
                        count: sliderViewObject.numberOfSlides,
                        effect: ExpandingDotsEffect(
                          dotColor: ColorManager.lightPrimaryColor,
                          activeDotColor: ColorManager.white,
                        ),
                      ),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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
