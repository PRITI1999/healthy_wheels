import 'package:flutter/material.dart';
import 'package:healthywheels/util/show_products.dart';

class ProductScreen extends StatefulWidget{
  String categoryName;
  String uid;
  ProductScreen(String name, String uid){
    this.categoryName = name;
    this.uid = uid;
  }
  @override
  _ProductScreenState createState() => _ProductScreenState(categoryName, uid);
}
class _ProductScreenState extends State<ProductScreen>{
  String categoryName;
  String uid;
  _ProductScreenState(String name, String uid){
    this.categoryName = name;
    this.uid = uid;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShowProducts(categoryName, uid),
    );
  }
}