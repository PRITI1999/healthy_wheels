import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthywheels/util/product_property.dart';
import 'package:healthywheels/util/show_cart_products.dart';

class CartScreen extends StatefulWidget {
  String uid;
  CartScreen(String uid){
    this.uid = uid;
  }
  @override
  _CartScreenState createState() => _CartScreenState(uid);
}

class _CartScreenState extends State<CartScreen> {
  List<Product> _cartProductList;
  double totalAmount;
  String uid;
  _CartScreenState(String uid) {
    this.uid = uid;
    totalAmount = 0;
    _cartProductList = new List<Product>();
    _cartProductList.add(new Product("Maize", "sub", "", 250, 2));
    _cartProductList.add(new Product("Maize", "sub", "",  25, 3));
    _calculateTotalAmount(_cartProductList);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 450,
          child: ShowCartProducts(_cartProductList, uid),
        ),
        Container(
            child: Row(
              children: <Widget>[
                Container(
                  height:50,
                  width: 220,
                  alignment: Alignment(0,0),
                  child:Text(
                    "Total amount: Rs. " + totalAmount.toString(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  width: 100,
                  alignment: Alignment(1, 0),
                  child:MaterialButton(
                    onPressed: checkOut,
                    color: Colors.black,
                    child: Text("Checkout", style: TextStyle(color: Colors.white70),),
                  )
                )
              ],
            ))
      ],
    );
  }

  void _calculateTotalAmount(List<Product> cartProductList) {
    for (int i = 0; i < cartProductList.length; i++) {
      totalAmount += cartProductList[i].price * cartProductList[i].quantity;
    }
  }

  void checkOut() {}
}