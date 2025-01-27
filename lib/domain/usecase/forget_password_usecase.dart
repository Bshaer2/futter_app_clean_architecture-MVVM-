import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordUseCaseInputs, Authentication> {
  final Repository _repository;

  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      ForgetPasswordUseCaseInputs input) async {
    return await _repository
        .resetPassword(ForgetPasswordRequest(input.userName));
  }
}

class ForgetPasswordUseCaseInputs {
  String userName;

  ForgetPasswordUseCaseInputs(this.userName);
}
