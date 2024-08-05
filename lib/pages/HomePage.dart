import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:torentyou/components/ProductCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:torentyou/consts.dart';
import 'package:torentyou/pages/ProductDetailsPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int activeIndex = 0; // To track the current slide
  final controller = CarouselController();
  List<Map<String, dynamic>> apiProducts = [
    {
      "imageUrl":
          'https://torentyou.com/admin/uploads/SofacumBed6_90e7bdd9-77de-4704-a83b-d5c895c643ce_540x.png',
      "title": "Fabric Sofa Cum Bed",
      "price": "500/Month",
      "category": "Furniture",
      "description": "bed sofa cum bed available",
    },
    {
      "imageUrl": 'https://torentyou.com/admin/uploads/room.jpg',
      "title": "Hotel Room",
      "price": "300/Month",
      "category": "Hotel"
    },
    {
      "imageUrl":
          'https://torentyou.com/admin/uploads/SofacumBed6_90e7bdd9-77de-4704-a83b-d5c895c643ce_540x.png',
      "title": "Fabric Sofa Cum Bed",
      "price": "500/Month",
      "category": "Furniture"
    },
    {
      "imageUrl": 'https://torentyou.com/admin/uploads/room.jpg',
      "title": "Wooden Study Table",
      "price": "300/Month",
      "category": "Furniture"
    },
  ];

  // Search Functionality
  String _searchText = "";
  List<Map<String, dynamic>> _filteredProducts = [];
  List<String> carouselImages = [
    'https://torentyou.com/admin/uploads/SofacumBed6_90e7bdd9-77de-4704-a83b-d5c895c643ce_540x.png',
    'https://torentyou.com/admin/uploads/room.jpg',
    // Add more image URLs as needed
  ];

  @override
  void initState() {
    super.initState();
    _filteredProducts = apiProducts; // Initially show all products
  }

  void _searchProducts(String query) {
    setState(() {
      _searchText = query;
      _filteredProducts = apiProducts
          .where((product) =>
              product['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 8, right: 8, bottom: 10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search products...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius:
                    BorderRadius.circular(30.0), // Added border radius
                borderSide: BorderSide(
                    color: Colors.grey.shade300), // Remove default border
              ),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10.0),
        //   child: SizedBox(
        //     height: 1,
        //     child: Container(
        //       color: Colors.grey,
        //     ),
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack( // Use a Stack to overlay dots on the CarouselSlider
            children: [
              CarouselSlider(
                carouselController: controller, // Add controller
                options: CarouselOptions(
                  animateToClosest: true,
                  viewportFraction: 1,
                  height: 230.0, // Adjust height as needed
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() => activeIndex = index); // Update activeIndex
                  },
                  // ... your existing carousel options ...
                ),
                items: carouselImages.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 10, // Adjust position as needed
                left: 0,
                right: 0,
                child: Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: carouselImages.length,
                    effect: const SlideEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.backgroundColor, // Customize colors
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: SizedBox(
            height: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.5),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: _filteredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              final product = _filteredProducts[index];
              return ProductCard(
                title: product['title'],
                imageUrl: product['imageUrl'],
                price: product['price'],
                category: product['category'],
                onRentNow: () {
                  // ... your rent now logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsPage(product: product),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
