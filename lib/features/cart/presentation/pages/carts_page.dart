import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kidame_gebiya/app_constant.dart';
import 'package:kidame_gebiya/features/cart/bloc/cart/cart_bloc.dart';
import 'package:kidame_gebiya/features/cart/bloc/cart/cart_event.dart';
import 'package:kidame_gebiya/features/cart/bloc/cart/cart_state.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text('My Carts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartBloc()..add(FetchUserCarts()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state){
            if(state is CartLoading){
              return const Center(child: CupertinoActivityIndicator(),);
            }
            
            if(state is CartError){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error, textAlign: TextAlign.center,),
                  
                  const SizedBox(height: 20),
                  
                  IconButton(
                    onPressed: (){
                      context.read<CartBloc>().add(FetchUserCarts());
                    }, 
                    icon: const Icon(Icons.refresh, size: 30,))
                ],
              );
            }
            
            if(state is CartLoaded){
              return SafeArea(
                child: ListView.builder(
                  itemCount: state.userCarts.length,
                  itemBuilder: (context, index){
                    CartModel cart = state.userCarts[index];
                    return GestureDetector(
                      onTap: () => context.push('/carts/cart_detail', extra: cart),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: greyColor, width: .3),
                          boxShadow: const [
                            BoxShadow(
                              color: greyColor,
                              blurRadius: 2,
                            )
                          ]
                        ),
                        child: ListTile(
                          title: Text("Cart ${cart.id}", 
                            style: const TextStyle(fontWeight: FontWeight.w500),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(DateFormat('MMM d y').format(cart.date), 
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkGreyColor),),
                              const SizedBox(width: 4),
                              const Icon(CupertinoIcons.chevron_right, size: 18,)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              );
            }
            
            return const SizedBox.shrink();
        }),
      ),
    );
  }
}