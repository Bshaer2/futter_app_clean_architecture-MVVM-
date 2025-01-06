import 'package:tut_app/app/extensions.dart';
import 'package:tut_app/domain/models.dart';

import '../../data/responses/responses.dart';

extension UserResponseMapper on UserResponse {
  User toDomain() {
    return User(
        id: id.orEmpty(),
        name: name.orEmpty(),
        numberOfNotifications: numberOfNotifications.orZero());
  }
}

extension ContactsResponseMapper on ContactsResponse {
  Contacts toDomain() {
    return Contacts(
        phone: phone.orEmpty(), email: email.orEmpty(), link: link.orEmpty());
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse {
  Authentication toDomain() {
    return Authentication(
        user: user?.toDomain(), contacts: contacts?.toDomain());
  }
}
