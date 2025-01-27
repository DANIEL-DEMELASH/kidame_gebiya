import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required int id,
    required int userId,
    required DateTime date,
    required List<CartProduct> products,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}

@freezed
class CartProduct with _$CartProduct {
  const factory CartProduct({
    required int productId,
    required int quantity,
  }) = _CartProduct;

  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);
}