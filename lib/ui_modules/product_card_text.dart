import 'package:flutter/material.dart';

class ProductSubtitle extends StatelessWidget {
  final String text;
  ProductSubtitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
        color: Colors.grey
    ));
  }
}

class ProductTitle extends StatelessWidget {
  final String text;
  ProductTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18.0
    ),);
  }
}
class ProductPrice extends StatelessWidget {
  final String text;

  ProductPrice(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0
    ),);
  }
}