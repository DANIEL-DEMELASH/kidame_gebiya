import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String username,
    required String password,
    required Name name,
    required Address address,
    required String phone,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Name with _$Name {
  const factory Name({
    required String firstname,
    required String lastname,
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    required Geolocation geolocation,
    required String city,
    required String street,
    required int number,
    required String zipcode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}

@freezed
class Geolocation with _$Geolocation {
  const factory Geolocation({
    required String lat,
    required String long,
  }) = _Geolocation;

  factory Geolocation.fromJson(Map<String, dynamic> json) => _$GeolocationFromJson(json);
}