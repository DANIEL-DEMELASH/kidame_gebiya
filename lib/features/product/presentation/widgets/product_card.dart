import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.currentProduct});
  final ProductModel currentProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyColor, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
        children: [
          Hero(
            tag: 'location-img${currentProduct.image}',
            child: CachedNetworkImage(
              imageUrl: currentProduct.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: Text(error.toString()),),
            ),
          ),
          
          const SizedBox(height: 18),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      currentProduct.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: darkGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 17,
                      ),
                      
                      const SizedBox(width: 4), // Add spacing
                      
                      Text(
                        currentProduct.rating.rate.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(width: 4), // Add spacing
                      
                      Text('(${currentProduct.rating.count})',
                        style: const TextStyle(
                          fontSize: 12,
                          color: darkGreyColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 4),
              
              Text(
                currentProduct.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Restrict to 2 lines
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 4),
              
              Text(
                '\$${currentProduct.price}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}