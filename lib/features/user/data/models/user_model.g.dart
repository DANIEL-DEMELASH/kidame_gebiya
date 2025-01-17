// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      version: (json['version'] as num).toInt(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      'version': instance.version,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      geolocation:
          Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
      city: json['city'] as String,
      street: json['street'] as String,
      number: (json['number'] as num).toInt(),
      zipcode: json['zipcode'] as String,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'geolocation': instance.geolocation,
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'zipcode': instance.zipcode,
    };

_$GeolocationImpl _$$GeolocationImplFromJson(Map<String, dynamic> json) =>
    _$GeolocationImpl(
      lat: json['lat'] as String,
      long: json['long'] as String,
    );

Map<String, dynamic> _$$GeolocationImplToJson(_$GeolocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };

_$NameImpl _$$NameImplFromJson(Map<String, dynamic> json) => _$NameImpl(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );

Map<String, dynamic> _$$NameImplToJson(_$NameImpl instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
