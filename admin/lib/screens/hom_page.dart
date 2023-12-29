import 'package:flutter/material.dart';
import 'package:medi_deliver/component/ProductWidget.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/screens/addprodcut.dart';
import 'package:medi_deliver/screens/itemPage.dart';
import 'package:medi_deliver/screens/searchPage.dart';

class homPage extends StatelessWidget {
  const homPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border(
                          left: BorderSide(
                        color: buttonColor,
                        width: 2,
                      )),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('asset/images/profile.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Doctor',
                          style: const TextStyle(
                            fontFamily: fontFamilyString,
                            fontSize: 18,
                            color: buttonColor,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'asset/images/map.png',
                              width: 20,
                            ),
                            Text(
                              'Assut , City',
                              style: const TextStyle(
                                fontFamily: 'DINNextLTW23s',
                                fontSize: 15,
                                color: fontSecondaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Image.asset('asset/images/notification.png')
                ],
              ),
              SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                },
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Search For A medicine A specific Product',
                      hintStyle: const TextStyle(
                        fontFamily: fontFamilyString,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => QRScannerPage(),
                            //   ),
                            // );
                          },
                          icon: Image.asset('asset/images/barcode.png')),
                      prefixIcon: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ));
                          },
                          icon: Image.asset('asset/images/search.png'))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // image Slider
              const SizedBox(
                height: 10,
              ),
              //--------------Start of Categories-------------------------
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: fontFamilyString,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigate to Categories Page
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: fontFamilyString,
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      name: categoriesList[index]["name"]!,
                      imagePath: categoriesList[index]["imagePath"]!,
                      onTap: () {
                        categoryList = productList
                            .where((product) =>
                                product.category.toLowerCase() ==
                                categoriesList[index]["name"]!.toLowerCase())
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsPage(
                              products: categoryList,
                              categoryName: categoriesList[index]["name"]!,
                            ),
                          ),
                        );
                      },
                    );
                  },

                  // return CategoryCard();
                ),
              ),
              //  -------------------------Start of Items List
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: const Text('Popular Products',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamilyString,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 280,
                child: StreamBuilder<List<Product>>(
                  stream: fetchProductsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: buttonColor,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      productList = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          categoryList.addAll(productList);
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ProductWidget(
                              product: productList[index],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 70,
              ),
              
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProduct()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                      
                      color: linksColor,
                      borderRadius: BorderRadius.circular(15),
                      
                    ),
                    height: 45,
                    width: 130,
                    child: Center(
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: fontFamilyString,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  String name;
  final VoidCallback onTap;

  String imagePath;
  CategoryCard({
    required this.onTap,
    required this.name,
    required this.imagePath,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Card(
                  color: Colors.grey[200],
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: fontFamilyString,
            ),
          ),
        ],
      ),
    );
  }
}
