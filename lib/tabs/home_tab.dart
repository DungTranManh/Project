import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/widgets/custom_action_bar.dart';
import 'package:shop_app/widgets/product_cart.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(top: 100.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document['name'],
                      imageURL: document['images'][0],
                      price: "\$${document['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              //Loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            hasTitle: true,
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
