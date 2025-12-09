import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../database/database.dart';

class ProductDetailsSheet extends StatefulWidget {
  final Product product;
  final AppDatabase database;
  final VoidCallback onAddedToBag;

  ProductDetailsSheet(
      {required this.product,
      required this.database,
      required this.onAddedToBag});

  @override
  _ProductDetailsSheetState createState() => _ProductDetailsSheetState();
}

class _ProductDetailsSheetState extends State<ProductDetailsSheet> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Parse colors and sizes from strings like "[Red, Blue]" to lists
    final colors = widget.product.colors
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    final sizes = widget.product.sizes
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((e) => e.trim())
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height *
          0.85, // Slightly taller for the new buttons
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2)),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Fixed Price Display
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 24),

                  // --- Colors ---
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
                            color: isSelected ? Colors.white : Colors.black),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),

                  // --- Sizes ---
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
                            color: isSelected ? Colors.white : Colors.black),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24),

                  // --- NEW: Quantity Selector ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              color: quantity > 1 ? Colors.black : Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                if (quantity < widget.product.stock) {
                                  setState(() => quantity++);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Max stock reached'),
                                        duration: Duration(milliseconds: 500)),
                                  );
                                }
                              },
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
                  Text(
                    'Stock: ${widget.product.stock} available',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          // --- Add to Bag Button ---
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
              onPressed: () async {
                if (selectedColor == null || selectedSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select color and size')),
                  );
                  return;
                }

                // Add to database
                await widget.database.insertBagItem(
                  BagItemsCompanion.insert(
                    productId: widget.product.id,
                    selectedColor: selectedColor!,
                    selectedSize: selectedSize!,
                    quantity: quantity,
                  ),
                );

                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added to bag!')));
                widget.onAddedToBag();
              },
              child: Text(
                  'Add to Bag - \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
