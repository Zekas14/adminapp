import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/component/view_product_button.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/product.dart';

// ignore: must_be_immutableZ
class ProductWidget extends StatefulWidget {
  Product product;
  ProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      constraints: const BoxConstraints(maxWidth: 160, maxHeight: 300),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                //  margin: const EdgeInsets.only(top: 10),
                constraints: const BoxConstraints(
                    maxWidth: 130, maxHeight: 114, minHeight: 114),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Image.network(
                    widget.product.imagePath,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.product.description,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontFamily: fontFamilyString,
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  Container(
                    alignment: Alignment.topLeft,
                 //   margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "${widget.product.price.toStringAsFixed(2)} EGP",
                      style: const TextStyle(
                          color: Color(0xFFE34C55),
                          fontFamily: fontFamilyString,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ViewButton(
                    product: widget.product,
                  ),
                ],
              ),
              // SizedBox(height: 10,),
              // ViewButton(
              //   product: widget.product,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
