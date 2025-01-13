import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base_view_model/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final Login _login = Login(userName: "", password: "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);


  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get areAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  login() async {
    (await (_loginUseCase
            .execute(LoginUseCaseInput(_login.userName, _login.password))))
        .fold((failure) {}, (data) {});
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    _areAllInputsValidStreamController.add(null);
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => isUserNameValid(userName));

  bool isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool isUserNameValid(String password) {
    return password.isNotEmpty;
  }

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return (isUserNameValid(_login.userName) &&
        isPasswordValid(_login.password));
  }
}

abstract mixin class LoginViewModelInput {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get areAllInputsValid;
}

abstract mixin class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
