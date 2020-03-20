import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthywheels/ui_modules/product_card.dart';
import 'package:healthywheels/util/product_property.dart';

class ShowProducts extends StatelessWidget {
  Iterable<String> products;
  String categoryName;
  String uid;
  ShowProducts(this.categoryName, this.uid);

  makeProductCards(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((doc){
      var currentProduct = getProductDetails(json.encode(doc.data));
      return Container(child: ProductCard(currentProduct, uid),);
    }).toList();
  }

  Widget _showProducts(BuildContext context, String categoryName) {
    return new StreamBuilder(
      stream: Firestore.instance.collection("categories")
          .document(categoryName).collection("products").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        return ListView(
          children: makeProductCards(context, snapshot),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _showProducts(context, categoryName);
  }

  Product getProductDetails(product) {
    var decodedProduct = jsonDecode(product);
    return new Product(decodedProduct['name'], decodedProduct['subname'], decodedProduct['productId'],
        double.parse(decodedProduct['price'].toString()), decodedProduct['count']);
  }
}