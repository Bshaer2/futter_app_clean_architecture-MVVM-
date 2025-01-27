import 'dart:async';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel with BaseViewModelInput, BaseViewModelOutput {
  final StreamController <FlowState> _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream <FlowState> get  outputState => _inputStreamController.stream
      .map((flowState) => flowState);
}

abstract mixin class BaseViewModelInput {
  void start();

  void dispose();

  Sink get inputState;
}

abstract mixin class BaseViewModelOutput {
  Stream <FlowState> get outputState;
}
