import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/model/product.dart';

class ProductView extends StatefulWidget {
  Product? product;
  ProductView({Key? key, this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Map<String, dynamic>? productdata;

  @override
  Widget build(BuildContext context) {
    var productdata2 = FirebaseFirestore.instance.collection('Products');

    return FutureBuilder<DocumentSnapshot>(
      future: productdata2.doc('eD1xeusukK6hRqmLe7YC').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    print(productdata);
                  
                       Navigator.pop(context);
                  },
                ),
                title: Text(
                  widget.product!.name,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red[600],
                    ),
                    onPressed: () {
                      _showRemoveConfirmationDialog(context);
                    },
                  ),
                ] //IconButton,
                ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(17),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image placeholder (replace with actual image)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Image.network(widget.product!.imagePath,
                            height: 120.0, width: 120.0),
                      ),
                      const SizedBox(height: 20.0),
                      // Description fields
                      _buildDescriptionField('Name', widget.product!.name,
                          textColor: Color(0xFF000000)),
                      const SizedBox(height: 10.0),
                      _buildDescriptionField('Price', widget.product!.price.toString(),
                          textColor: Color(0xFFE34C55)),
                      const SizedBox(height: 10.0),
                      _buildDescriptionField('Description', widget.product!.description,
                          textColor: Color(0xFF000000)),
                      const SizedBox(height: 15.0),
                      _buildDescriptionField('Category', widget.product!.category,
                          textColor: Color(0xFF000000)),
                      const SizedBox(height: 15.0),
                      _buildDescriptionField(
                          'Quantity', widget.product!.quantity.toString() + ' ' + 'Unit',
                          textColor: Color(0xFFE34C55)),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  Widget _buildDescriptionField(String label, String placeholder,
      {Color? textColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Labels column
          Container(
            width: 120.0,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7A869A),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          // Values column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                placeholder,
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor ?? Color(0xFF000000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Product'),
          content: const Text('Are you sure you want to remove this product?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle product removal logic here
                var db = FirebaseFirestore.instance;
                db.collection('Products').doc('eD1xeusukK6hRqmLe7YC').delete();

                Navigator.pop(context);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}

class EditProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Center(
        child: Text('Editing product details goes here...'),
      ),
    );
  }
}
