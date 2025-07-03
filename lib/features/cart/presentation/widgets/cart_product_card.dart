
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app_constant.dart';
import '../../../product/data/models/product_model.dart';
import '../../data/models/cart_model.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.product, 
    required this.cartProduct,
  });

  final ProductModel product;
  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: false, 
            onChanged: (value){
          }),
          
          CachedNetworkImage(
            imageUrl: product.image, fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Placeholder(),
          )
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: darkGreyColor),),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$${product.price}", 
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
              
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor)
                    ),
                    child: const Text('-', textAlign: TextAlign.center, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),),
                  ),
                ),
                
                const SizedBox(width: 12),
                
                Text(cartProduct.quantity.toString()),
                
                const SizedBox(width: 12),
                
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor)
                    ),
                    child: const Text('+', textAlign: TextAlign.center, style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}