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
          productId: widget.product.id,
          likedAt: DateTime.now(),
        ),
      );
    }
    setState(() => isLiked = !isLiked);
    widget.onLikeToggled();
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Center(child: Icon(Icons.image, size: 50, color: Colors.grey));
    }
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)),
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = widget.product.images
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    return Stack(
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: _buildImage(imagePath),
                  ),
                ),

                // Product Info
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      widget.product.stock > 0
                          ? Text(
                              '₱${widget.product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              'Out of Stock',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Heart Icon Overlay
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.black,
                size: 20,
              ),
              onPressed: _toggleLike,
              padding: EdgeInsets.all(8),
              constraints: BoxConstraints(),
            ),
          ),
        ),
      ],
    );
  }
}
