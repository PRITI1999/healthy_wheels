import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthywheels/ui_modules/product_card_text.dart';
import 'package:healthywheels/util/product_property.dart';

class ProductCard extends StatefulWidget {
  Product product;
  String uid;
  ProductCard(Product product, String uid){
    this.product = product;
    this.uid = uid;
  }
  @override
  _ProductCardState createState() => _ProductCardState(product, uid);
}

class _ProductCardState extends State<ProductCard> {
  Product product;
  String uid;
  bool found = false;
  List<Product> productsInCart;
  _ProductCardState(this.product, this.uid);

  @override
  initState(){
    productsInCart = new List<Product>();
    super.initState();
  }

  Product getProductDetails(product) {
    var decodedProduct = jsonDecode(product);
    return new Product(decodedProduct['name'], decodedProduct['subname'], decodedProduct['productId'],
        double.parse(decodedProduct['price'].toString()), decodedProduct['count']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.orange.shade200,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 3,
              color: Colors.orange.shade200,
            )),
        child: Row(
          children: <Widget>[
          const SizedBox(width: 5.0),
          Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  borderRadius: BorderRadius.circular(10.0),
                  ),
              height: 80.0,
              width: 80.0,
              child: Image.asset('assets/images/logo.png')),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              height: 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new ProductTitle(product.title),
                  new ProductSubtitle(product.subtitle)
                ],
              ),
            ),
          ),
          //const SizedBox(width: 5.0),
          Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new ProductPrice("Price: " + product.price.toString()),
                  ],
                ),
              ),
              //const SizedBox(width: 5.0,),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    highlightColor: Colors.orange.shade50,
                    color: Colors.orange,
                    onPressed: () {

                        Firestore.instance.collection("users").document(
                            uid
                        )
                            .collection("cart").getDocuments().then((snapshot){
                          snapshot.documents.forEach((doc){
                            String currentProductId = getProductDetails(json.encode(doc.data)).productId;
                            int count = getProductDetails(json.encode(doc.data)).quantity;
                            if(currentProductId == product.productId){
                              if(count == 1){
                                Firestore.instance.collection("users").document(uid)
                                    .collection("cart").document(doc.documentID).delete();
                              }else {
                                Firestore.instance.collection("users").document(
                                    uid)
                                    .collection("cart").document(doc.documentID)
                                    .updateData({"count": count - 1});
                              }
                            }
                          });
                        });

                        setState(() {

                        });
                    },
                  ),
                  Text(
                    product.quantity.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    color: Colors.orange,
                    onPressed: () {
                        Firestore.instance.collection("users").document(
                            uid
                        )
                            .collection("cart").getDocuments().then((snapshot){
                          snapshot.documents.forEach((doc){
                            String currentProductId = getProductDetails(json.encode(doc.data)).productId;
                            int count = getProductDetails(json.encode(doc.data)).quantity;
                            if(currentProductId == product.productId){
                              found = true;
                              Firestore.instance.collection("users").document(uid)
                                  .collection("cart").document(doc.documentID)
                                  .updateData({"count": count + 1});
                            }
                          });
                          if(!found){
                            Firestore.instance.collection("users").document(uid)
                                .collection("cart").add({
                              "name": product.title,
                              "subname": product.subtitle,
                              "productId": product.productId,
                              "price": product.price,
                              "count": 1
                            });
                          }
                        });

                          setState(() {
                            found = false;

                          });
                    },
                  )
                ],
              ),
            ],
          )

          // const SizedBox(width: 10.0),
        ],
      ),
    ));
  }
}
