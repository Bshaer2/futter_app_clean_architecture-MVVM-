import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/colors_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
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
}
