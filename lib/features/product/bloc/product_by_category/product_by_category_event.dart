abstract class ProductByCategoryEvent {}

class FetchProductByCategory extends ProductByCategoryEvent {
  final String productCategory;

  FetchProductByCategory({required this.productCategory});
}
