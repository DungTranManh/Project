import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageURL;
  final String title;
  final String price;
  ProductCard(
      {this.title, this.onPressed, this.imageURL, this.price, this.productId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageURL",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 10.0,
              right: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Constants.regularHeading,
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
