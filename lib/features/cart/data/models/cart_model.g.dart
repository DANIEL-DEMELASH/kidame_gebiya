// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'date': instance.date.toIso8601String(),
      'products': instance.products,
    };

_$CartProductImpl _$$CartProductImplFromJson(Map<String, dynamic> json) =>
    _$CartProductImpl(
      productId: (json['productId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$CartProductImplToJson(_$CartProductImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
