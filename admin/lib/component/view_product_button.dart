import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/screens/viewproduct.dart';

// ignore: must_be_immutable
class ViewButton extends StatelessWidget {
  Product product;
  ViewButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          // navigate to Prooduct Details Page
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ProductView(
                product: product,
              );
            },
          ));
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(140, 38),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'View',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: fontFamilyString,
          ),
        ),
      ),
    );
  }
}
