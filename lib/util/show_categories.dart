import 'package:flutter/material.dart';
import 'package:healthywheels/screens/basic_skeleton.dart';
import '../ui_modules/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowCategories extends StatefulWidget{
  String uid;
  ShowCategories(String uid){
    this.uid = uid;
  }
  @override
  ShowCategoriesState createState() => ShowCategoriesState(uid);
}

class ShowCategoriesState extends State<ShowCategories> {

  String uid;
  ShowCategoriesState(this.uid);

  var categories = [];
  
  makeCategoryCards(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
    return snapshot.data.documents.map((doc){
      return GestureDetector(
        child: CategoryCard(doc.documentID),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BasicPage(3, uid, name: doc.documentID,)
            )
          )
        },
      );
    }).toList();
  }

  Widget _showCategories(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance.collection("categories").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          categories = snapshot.data.documents.map((doc) => doc.documentID).toList();
          return ListView(
            children: makeCategoryCards(context, snapshot),
          );
          /*return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CategoryCard(categories[index]),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BasicPage(3, uid, name:categories[index]),
                      ),
                    ),
                  },
                );
              });*/
        });
  }

  @override
  Widget build(BuildContext context) {
    return _showCategories(context);
  }
}