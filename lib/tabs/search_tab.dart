import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/firebase_servies.dart';
import 'package:shop_app/widgets/custom_input.dart';

import '../widgets/product_cart.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef.orderBy("name").startAt(
                  [_searchString]).endAt(["$_searchString\uf8ff}"]).get(),
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
                    padding: EdgeInsets.only(top: 128.0),
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
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                setState(
                  () {
                    _searchString = value;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
