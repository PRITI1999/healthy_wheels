import 'package:flutter/material.dart';
import 'package:healthywheels/screens/basic_skeleton.dart';
import '../ui_modules/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowCategories extends StatefulWidget{
  @override
  ShowCategoriesState createState() => ShowCategoriesState();
}

class ShowCategoriesState extends State<ShowCategories> {

  var categories = [];

  Widget _showCategories(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection("categories").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          categories = snapshot.data.documents.map((doc) => doc.documentID).toList();
          return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CategoryCard(categories[index]),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BasicPage(3, name:categories[index]),
                      ),
                    ),
                  },
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return _showCategories(context);
  }
}