import 'package:flutter/material.dart';
import 'package:healthywheels/ui_modules/product_card.dart';
import 'package:healthywheels/util/product_property.dart';

class ShowCartProducts extends StatelessWidget{
  List<Product> _cartProductList;
  String uid;
  ShowCartProducts(this._cartProductList, this.uid);
  Widget _showCartProducts(BuildContext context) {
    return ListView.builder(
      itemCount: _cartProductList.length,
      itemBuilder: (context, index) {
        return Container(
            child: ProductCard(_cartProductList[index], uid)
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _showCartProducts(context),
    );
  }
}