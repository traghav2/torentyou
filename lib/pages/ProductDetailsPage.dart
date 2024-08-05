import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torentyou/components/Button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:torentyou/consts.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  void _shareProduct() async {
    final subject = 'Check out this ${product['category']} on TorentYou!';
    final text = '${product['title']} - ${product['description']}';
    final imageUrl = product['imageUrl']; // Get the image URL

    try {
      await Share.share(
        '$subject\n\n$text\n\n$imageUrl',
        subject: subject,
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 0, 0),
      );
    } catch (error) {
      print('Error sharing product: $error');
      // Optionally show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Image(image: AssetImage('assets/logo.png'),  // Replace with your logo file path
            width: 110,  // Adjust size as needed
            height: 110,),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            height: 1.0,
            color: AppColors.dividerColor.withOpacity(0.5),
          ),
        ),// Default title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product['imageUrl'] ?? '', // Default empty image URL
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Add error handling
                  return const Icon(Icons.error); // Show error icon
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
            const SizedBox(height: 30),

            Text(
              '${product['category'] ?? 'N/A'}', // 'N/A' if price is null
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey.shade700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                child: Container(
                  height: 0.7,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Text(
              product['description'] ?? 'No Description Available',
              style: const TextStyle(fontSize: 16),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                child: Container(
                  height: 0.7,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            InkWell(
              onTap: _shareProduct,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Share",
                    style: TextStyle(fontSize: 19),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: _shareProduct,
                  ),
                  // Add more icons for other sharing platforms if needed
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 20.0),
              child: SizedBox(
                child: Container(
                  height: 0.7,
                  color: Colors.grey.shade400,
                ),
              ),
            ),


            ButtonCustom(
                callback: () {},
                title: "Chat Now",
                gradient: const LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryTextColor,
                ]))
          ],
        ),
      ),
    );
  }
}
