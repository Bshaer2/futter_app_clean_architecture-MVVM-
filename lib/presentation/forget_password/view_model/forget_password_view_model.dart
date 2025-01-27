import 'dart:async';

import 'package:tut_app/presentation/base_view_model/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController<String> _userNameStreamController =
      StreamController.broadcast();

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  // TODO: implement isUserNameValid
  Stream<bool> get isUserNameValid => _userNameStreamController.stream
      .map((userName) => isForgetPasswordUserNameValid(userName));

  bool isForgetPasswordUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  resetPassword(){

  }
}

abstract mixin class ForgetPasswordViewModelInputs {
  Sink get inputUserName;
}

abstract mixin class ForgetPasswordViewModelOutputs {
  Stream<bool> get isUserNameValid;
}
