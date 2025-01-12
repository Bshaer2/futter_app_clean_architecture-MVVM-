

import 'dart:async';

import 'package:tut_app/presentation/base_view_model/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput, LoginViewModelOutput{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final Login _login = Login(userName: "userName", password: "password");
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
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
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);

  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream.map((userName) => isUserNameValid(userName));

  bool isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool isUserNameValid(String password){
    return password.isNotEmpty;
  }

}

abstract mixin class LoginViewModelInput{
  setUserName(String userName);
  setPassword(String password);
  login();

 Sink get inputUserName;
 Sink get inputPassword;
}

abstract mixin class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;

}