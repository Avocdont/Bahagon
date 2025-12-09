import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:io';
import '../database/database.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final AppDatabase database;
  final VoidCallback onTap;
  final VoidCallback onLikeToggled;

  ProductCard({
    required this.product,
    required this.database,
    required this.onTap,
    required this.onLikeToggled,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _checkLikeStatus();
  }

  Future<void> _checkLikeStatus() async {
    final liked = await widget.database.isLiked(widget.product.id);
    setState(() => isLiked = liked);
  }

  Future<void> _toggleLike() async {
    if (isLiked) {
      await widget.database.deleteLike(widget.product.id);
    } else {
      await widget.database.insertLike(
        LikesCompanion.insert(
            productId: widget.product.id, likedAt: DateTime.now()),
      );
    }
    setState(() => isLiked = !isLiked);
    widget.onLikeToggled();
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isEmpty)
      return Center(child: Icon(Icons.image, size: 50, color: Colors.grey));
    if (imagePath.startsWith('http')) {
      return Image.network(imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)));
    } else {
      return Image.file(File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.product.images
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    child: _buildImage(imagePath),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black),
                      onPressed: _toggleLike,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  // FIX IS HERE: safer string interpolation for the price
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: widget.onTap,
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: Text('Add to Bag'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
