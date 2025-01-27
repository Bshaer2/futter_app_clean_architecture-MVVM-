import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/dependency_injection.dart';
import '../../resources/route_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _keyForm = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_){
          _appPreferences.setIsUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);

        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(
                      context, _getContentWidget(context), () {
                    _viewModel.login();
                  }) ??
                  _getContentWidget(context);
            }));
  }

  Widget _getContentWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.padding100),
      child: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.padding100,
                  ),
                  child: Image(image: AssetImage(ImageManager.splashImage)),
                ),
              ),
              const SizedBox(height: AppSize.size28),
              //Email text field
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: ColorManager.black),
                            hintText: AppStrings.userName,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.userNameError),
                      );
                    }),
              ),
              const SizedBox(height: AppSize.size28),
              //password text field
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    }),
              ),
              const SizedBox(height: AppSize.size28),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.size50,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: const Text(AppStrings.login),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: AppSize.size8),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, Routes.forgerPasswordRoute),
                        child: Text(
                          AppStrings.forgerPassword,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.registerRoute),
                      child: Text(
                        AppStrings.register,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
