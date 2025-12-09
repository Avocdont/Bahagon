import 'package:flutter/material.dart';
import 'dart:io';
import '../database/database.dart';
import '../widgets/product_details_sheet.dart'; // Import the details sheet

class LikesScreen extends StatefulWidget {
  final AppDatabase database;

  LikesScreen({required this.database});

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  List<Product> likedProducts = [];

  @override
  void initState() {
    super.initState();
    _loadLikedProducts();
  }

  Future<void> _loadLikedProducts() async {
    final likes = await widget.database.getAllLikes();
    final products = await widget.database.getAllProducts();

    setState(() {
      likedProducts =
          products.where((p) => likes.any((l) => l.productId == p.id)).toList();
    });
  }

  // Helper to show the details popup
  void _showProductDetails(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsSheet(
        product: product,
        database: widget.database,
        onAddedToBag: () {
          // Optional: Refresh logic if needed, or just close
        },
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isEmpty) return Icon(Icons.image, color: Colors.grey);
    if (imagePath.startsWith('http')) {
      return Image.network(imagePath,
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => Icon(Icons.error));
    } else {
      return Image.file(File(imagePath),
          fit: BoxFit.cover, errorBuilder: (_, __, ___) => Icon(Icons.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Likes', style: TextStyle(fontWeight: FontWeight.bold))),
      body: likedProducts.isEmpty
          ? Center(child: Text('No liked products yet'))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: likedProducts.length,
              itemBuilder: (context, index) {
                final product = likedProducts[index];
                final imagePath = product.images
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll('"', '');

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    onTap: () =>
                        _showProductDetails(product), // Added onTap here
                    contentPadding: EdgeInsets.all(12),
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildImage(imagePath),
                      ),
                    ),
                    title: Text(product.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () async {
                        await widget.database.deleteLike(product.id);
                        _loadLikedProducts();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
