import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class Login with _$Login {
  factory Login({
    required String  userName,  required String password}) = _Login;

}