import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/models/models.dart';

import '../../data/network/requests.dart';

abstract class Repository{
Future <Either<Failure, Authentication>> login(LoginRequest loginRequest);

Future<Either<Failure, Authentication>> resetPassword(ForgetPasswordRequest forgetPasswordRequest);
}