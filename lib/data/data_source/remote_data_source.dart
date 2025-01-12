import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/responses/responses.dart';

import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceIml implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceIml(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
