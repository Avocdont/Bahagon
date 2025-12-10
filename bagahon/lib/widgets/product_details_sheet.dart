import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:io';
import '../database/database.dart';

class ProductDetailsSheet extends StatefulWidget {
  final Product product;
  final AppDatabase database;
  final VoidCallback onAddedToBag;

  ProductDetailsSheet({
    required this.product,
    required this.database,
    required this.onAddedToBag,
  });

  @override
  _ProductDetailsSheetState createState() => _ProductDetailsSheetState();
}

class _ProductDetailsSheetState extends State<ProductDetailsSheet> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;
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
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.product.colors
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final sizes = widget.product.sizes
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final imagePath = widget.product.images
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    final isOutOfStock = widget.product.stock <= 0;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image + Heart Icon Overlay
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: imagePath.isNotEmpty
                            ? (imagePath.startsWith('http')
                                ? Image.network(imagePath,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Icon(Icons.error))
                                : Image.file(File(imagePath),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Icon(Icons.error)))
                            : Container(
                                height: 200,
                                color: Colors.grey[200],
                                child: Icon(Icons.image,
                                    size: 80, color: Colors.grey),
                              ),
                      ),
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
                              size: 22,
                            ),
                            onPressed: _toggleLike,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Product Name + Price
                  Text(widget.product.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  isOutOfStock
                      ? Text('Out of Stock',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : Text('₱${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),

                  SizedBox(height: 16),
                  Text(widget.product.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),

                  SizedBox(height: 24),
                  Text('Available Colors',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: colors.map((color) {
                      final isSelected = color == selectedColor;
                      return ChoiceChip(
                        label: Text(color),
                        selected: isSelected,
                        onSelected: (selected) =>
                            setState(() => selectedColor = color),
                        selectedColor: Colors.black,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 24),
                  Text('Available Sizes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: sizes.map((size) {
                      final isSelected = size == selectedSize;
                      return ChoiceChip(
                        label: Text(size),
                        selected: isSelected,
                        onSelected: (selected) =>
                            setState(() => selectedSize = size),
                        selectedColor: Colors.black,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: quantity > 1
                                  ? () => setState(() => quantity--)
                                  : null,
                              color: quantity > 1 ? Colors.black : Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('$quantity',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: quantity < widget.product.stock
                                  ? () => setState(() => quantity++)
                                  : null,
                              color: quantity < widget.product.stock
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Stock: ${widget.product.stock} available',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
          ),

          // Bottom Add to Bag Button
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))
              ],
            ),
            child: ElevatedButton(
              onPressed: isOutOfStock
                  ? null
                  : () async {
                      if (selectedColor == null || selectedSize == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Please select color and size')),
                        );
                        return;
                      }

                      await widget.database.insertBagItem(
                        BagItemsCompanion.insert(
                          productId: widget.product.id,
                          selectedColor: selectedColor!,
                          selectedSize: selectedSize!,
                          quantity: quantity,
                        ),
                      );

                      final newStock = (widget.product.stock - quantity)
                          .clamp(0, widget.product.stock);
                      final updatedProduct =
                          widget.product.copyWith(stock: newStock);
                      await widget.database.updateProduct(updatedProduct);

                      Navigator.pop(context);
                      widget.onAddedToBag();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to bag!')),
                      );
                    },
              child: Text(
                isOutOfStock
                    ? 'Out of Stock'
                    : 'Add to Bag - ₱${(widget.product.price * quantity).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
