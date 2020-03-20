import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthywheels/ui_modules/product_card.dart';
import 'package:healthywheels/util/product_property.dart';

class CartScreen extends StatefulWidget {
  String uid;
  CartScreen(String uid){
    this.uid = uid;
  }
  @override
  _CartScreenState createState() => _CartScreenState(uid);
}

class _CartScreenState extends State<CartScreen> {
  double totalAmount;
  String uid;
  _CartScreenState(String uid) {
    this.uid = uid;
    totalAmount = 0;
  }

  Product getProductDetails(product) {
    var decodedProduct = jsonDecode(product);
    return new Product(decodedProduct['name'], decodedProduct['subname'], decodedProduct['productId'],
        double.parse(decodedProduct['price'].toString()), decodedProduct['count']);
  }

  makeCartProducts(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((doc){
      var currentProduct = getProductDetails(json.encode(doc.data));
      totalAmount += currentProduct.price * currentProduct.quantity;
      return Container(child: ProductCard(currentProduct, uid),);
    }).toList();
  }

  Widget _showCartProducts(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection("users").document(uid).collection("cart").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        return ListView(
          children: makeCartProducts(context, snapshot),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 450,
          child: _showCartProducts(context),
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

  void checkOut() {}
}