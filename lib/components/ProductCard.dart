import 'package:flutter/material.dart';
import 'package:torentyou/components/Button.dart';
import 'package:torentyou/consts.dart';
import 'package:torentyou/pages/ProductDetailsPage.dart'; // Make sure this path is correct

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String category;
  final VoidCallback onRentNow;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.onRentNow,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: AppColors.cardOutlineColor.withOpacity(0.6),
              width: 1.7,
            ),
          ),
          color: Colors.white,
          child: InkWell(
            onTap: onRentNow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 127,
                  fit: BoxFit.fitWidth,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.currency_rupee_rounded, color: Colors.green, size: 17.5,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      price,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(left: 14.0, bottom: 12.0),
                        child: ButtonCustom(
                            callback: onRentNow,
                            title: "Rent Now",
                            gradient: const LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryTextColor,
                                ]
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
