import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(), 
          icon: const Icon(CupertinoIcons.chevron_back)),
        title:const Text('Product Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 286,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                // border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(12)
              ),
              child: InteractiveViewer(
                // boundaryMargin: EdgeInsets.all(20.0),
                minScale: 0.05,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(child: Text(error.toString()),),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .5,
                        child: Text(product.title, 
                          maxLines: 2, 
                          style: const TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w500),)
                      ),
                            
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              
                            }, 
                            icon: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFFD9D9D9),
                              child: Icon(Icons.share, size: 20, color: Colors.black,),
                            )
                          ),
                          
                          IconButton(
                            onPressed: (){
                              
                            }, 
                            icon: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFFD9D9D9),
                              child: Icon(Icons.bookmark_outline, size: 20, color: Colors.black,),
                            ))
                        ],
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price}',
                        style: const TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.w500),
                      ),
                      
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Text("${product.rating.rate}(${product.rating.count})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  Text(product.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor
                    ),
                  ),
                  
                  
                ],
              ),
            ),
             
          ],
        ),
      ),
      
      bottomSheet: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.zero
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  side: const BorderSide(
                    color: primaryColor
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FeatherIcons.shoppingBag, color: primaryColor, size: 18,),
                    SizedBox(width: 8),
                    Text('Add to cart', style: TextStyle(fontWeight: FontWeight.w500, color: primaryColor),),
                  ],
                )
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: TextButton(
                onPressed: (){}, 
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12)
                ),
                child: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }
}