import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/presentation/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Electronics', 'Jewelery', 'Men\'s Clothing', 'Women\'s Clothing'];
    
    List<ProductModel> productSamples = const [
      ProductModel(
        id: 1, 
        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", 
        price: 109.95, 
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", 
        category: "men's clothing", 
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", 
        rating: Rating(
          rate: 3.9, 
          count: 120)
      ),
      
      ProductModel(
        id: 2, 
        title: "Mens Casual Premium Slim Fit T-Shirts", 
        price: 22.3, 
        description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.", 
        category: "men's clothing", 
        image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg", 
        rating: Rating(
          rate: 4.1, 
          count: 259)
      ),
      
      ProductModel(
        id: 3, 
        title: "Mens Cotton Jacket", 
        price: 55.99, 
        description: "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.", 
        category: "men's clothing", 
        image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg", 
        rating: Rating(
          rate: 4.7, 
          count: 500)
      ),
      
      ProductModel(
        id: 4, 
        title: "Mens Casual Slim Fit", 
        price: 15.99, 
        description: "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.", 
        category: "men's clothing", 
        image: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg", 
        rating: Rating(
          rate: 2.1, 
          count: 430)
      ),
    ];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset('assets/icon/icon.png'),
        ),
        title: RichText(
          text: const TextSpan(
            text: 'ቅዳሜ ',
            style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: primaryColor),
            children: [
              TextSpan(text: 'ገቢያ', style: TextStyle(color: Colors.black))
            ]
          )
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              color: primaryColor.withOpacity(.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 12,
                    children: [
                      const Text('NEW COLLECTIONS', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                      
                      const Text('20% OFF', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                      
                      TextButton(
                        onPressed: (){}, 
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                          )
                        ),
                        child: const Text('SHOP NOW', style: TextStyle(color: Colors.white),))
                    ],
                  ),
                  
                  Image.asset('assets/images/calvin_girl.png', width: 130,)
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Shop By Category', style: TextStyle(fontWeight: FontWeight.w500),),
                  
                  TextButton(
                    onPressed: (){
                      
                    }, 
                    child: const Text('See All', style: TextStyle(color: darkGreyColor),))
                ],
              ),
            ),
            
            Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 12,
                  );
                },
                itemBuilder: (context, index){
                  return TextButton(
                    onPressed: (){
                      
                    }, 
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor.withOpacity(.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16)
                    ),
                    child: Text(categories[index], 
                      style: const TextStyle(color: Colors.black,  fontWeight: FontWeight.w500)
                    )
                  );
                }
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Curated For You', style: TextStyle(fontWeight: FontWeight.w500),),
                  
                  TextButton(
                    onPressed: (){
                      
                    }, 
                    child: const Text('See All', style: TextStyle(color: darkGreyColor),))
                ],
              ),
            ),
            
            MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productSamples.length,
              itemBuilder: (context, index) {
                return ProductCard(currentProduct: productSamples[index]);
              },
            )
    
          ],
        ),
      ),
    );
  }
}