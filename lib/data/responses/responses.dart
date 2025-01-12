import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int ? status;
  @JsonKey(name: "message")
  String ? message;

}

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "id")
  String ? id;
  @JsonKey(name: "name")
  String ? name;
  @JsonKey(name: "numberOfNotifications")
  int ? numberOfNotifications;

  UserResponse({this.id, this.name, this.numberOfNotifications});

  factory UserResponse.fromJson (Map<String, dynamic> json)  =>(_$UserResponseFromJson(json));

  Map<String, dynamic> toJason ()  =>(_$UserResponseToJson(this));
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String ? phone;
  @JsonKey(name: "email")
  String ? email;
  @JsonKey(name: "link")
  String ? link;

  ContactsResponse({this.phone, this.email, this.link});

  factory ContactsResponse.fromJson (Map<String, dynamic> json)  =>(_$ContactsResponseFromJson(json));

  Map<String, dynamic> toJason ()  =>(_$ContactsResponseToJson(this));
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "user")
  UserResponse ? user;
  @JsonKey(name: "contacts")
  ContactsResponse ? contacts;

  AuthenticationResponse({this.user, this.contacts});

  factory AuthenticationResponse.fromJson (Map<String, dynamic> json)  =>(_$AuthenticationResponseFromJson(json));

  Map<String, dynamic> toJason ()  =>(_$AuthenticationResponseToJson(this));


}