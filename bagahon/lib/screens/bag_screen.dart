import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';
import 'dart:io';
import '../database/database.dart';

class BagScreen extends StatefulWidget {
  final AppDatabase database;

  BagScreen({required this.database});

  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  List<BagItem> bagItems = [];
  List<Product> products = [];
  Set<int> selectedItems = {};
  final double shippingCost = 10.0;

  @override
  void initState() {
    super.initState();
    _loadBagItems();
  }

  Future<void> _loadBagItems() async {
    final items = await widget.database.getAllBagItems();
    final allProducts = await widget.database.getAllProducts();
    setState(() {
      bagItems = items;
      products = allProducts;
    });
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (var itemId in selectedItems) {
      final bagItem = bagItems.firstWhere((i) => i.id == itemId);
      final product = products.firstWhere((p) => p.id == bagItem.productId);
      subtotal += product.price * bagItem.quantity;
    }
    return subtotal;
  }

  double _calculateTotal() {
    return _calculateSubtotal() + (selectedItems.isNotEmpty ? shippingCost : 0);
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

  Future<void> _deleteItem(BagItem bagItem) async {
    await widget.database.deleteBagItem(bagItem.id);
    setState(() {
      selectedItems.remove(bagItem.id);
      bagItems.remove(bagItem);
    });
    _loadBagItems();
  }

  Future<void> _checkout() async {
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select items')));
      return;
    }

    final itemsToCheckout =
        bagItems.where((item) => selectedItems.contains(item.id)).toList();

    final transactionItems = itemsToCheckout.map((bagItem) {
      final product = products.firstWhere((p) => p.id == bagItem.productId);
      return {
        'productId': product.id,
        'name': product.name,
        'price': product.price,
        'quantity': bagItem.quantity,
        'color': bagItem.selectedColor,
        'size': bagItem.selectedSize,
      };
    }).toList();

    await widget.database.insertTransaction(
      TransactionsCompanion.insert(
        items: jsonEncode(transactionItems),
        total: _calculateTotal(),
        date: DateTime.now(),
        status: 'Completed',
      ),
    );

    await widget.database.clearBagItems(selectedItems.toList());

    setState(() {
      selectedItems.clear();
    });

    _loadBagItems();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Order placed successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bag', style: TextStyle(fontWeight: FontWeight.bold))),
      body: bagItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your bag is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: bagItems.length,
                    itemBuilder: (context, index) {
                      final bagItem = bagItems[index];
                      final product = products.firstWhere(
                          (p) => p.id == bagItem.productId,
                          orElse: () => products.first);
                      final isSelected = selectedItems.contains(bagItem.id);
                      final imagePath = product.images
                          .replaceAll('[', '')
                          .replaceAll(']', '')
                          .replaceAll('"', '');

                      return Dismissible(
                        key: Key(bagItem.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:
                              Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                        onDismissed: (direction) {
                          _deleteItem(bagItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${product.name} removed'),
                                duration: Duration(seconds: 1)),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true)
                                        selectedItems.add(bagItem.id);
                                      else
                                        selectedItems.remove(bagItem.id);
                                    });
                                  },
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: _buildImage(imagePath),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          'Color: ${bagItem.selectedColor}, Size: ${bagItem.selectedSize}'),
                                      Text('Qty: ${bagItem.quantity}'),
                                      Text(
                                        '\₱${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline,
                                      color: Colors.red),
                                  onPressed: () => _deleteItem(bagItem),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (selectedItems.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Subtotal:'),
                              Text(
                                  '\₱${_calculateSubtotal().toStringAsFixed(2)}')
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping:'),
                              Text('\₱${shippingCost.toStringAsFixed(2)}')
                            ]),
                        Divider(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('\₱${_calculateTotal().toStringAsFixed(2)}',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _checkout,
                          child: Text('Checkout'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 56)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
