import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../database/database.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  final AppDatabase database;
  final VoidCallback onProductsChanged;

  AdminScreen({required this.database, required this.onProductsChanged});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Product> products = [];
  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'Caps',
    'Shoes',
    'Pants',
    'Shorts',
    'Shirts',
    'Jackets',
    'T-shirts',
    'Socks',
    'Shades',
    'Watches'
  ];

  final List<String> _tags = [
    'New Arrivals',
    'Flash Deals',
    'Just For You',
    'Best Rated',
    'Hot Picks'
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await widget.database.getAllProducts();
    setState(() => products = loadedProducts);
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

  void _showAddEditDialog({Product? product}) {
    final isEditing = product != null;
    final nameController = TextEditingController(text: product?.name ?? '');
    final descController =
        TextEditingController(text: product?.description ?? '');
    final priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    final colorsController = TextEditingController(
        text: product?.colors
                .replaceAll('[', '')
                .replaceAll(']', '')
                .replaceAll('"', '') ??
            '');
    final sizesController = TextEditingController(
        text: product?.sizes
                .replaceAll('[', '')
                .replaceAll(']', '')
                .replaceAll('"', '') ??
            '');
    final stockController =
        TextEditingController(text: product?.stock.toString() ?? '');

    String currentImagePath = product?.images
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll('"', '') ??
        '';

    // Ensure selected category is valid (default to 'Caps')
    String selectedCategory = product?.category ?? 'Caps';
    if (!_categories.contains(selectedCategory)) selectedCategory = 'Caps';

    // Ensure selected tag is valid (default to 'New Arrivals')
    String selectedProductTag = product?.tag ?? 'New Arrivals';
    if (!_tags.contains(selectedProductTag))
      selectedProductTag = 'New Arrivals';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setStateDialog) {
        Future<void> _pickImage() async {
          final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setStateDialog(() {
              currentImagePath = image.path;
            });
          }
        }

        return AlertDialog(
          insetPadding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEditing ? 'Edit Product' : 'Add Product',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            constraints: BoxConstraints(maxWidth: 600),
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: currentImagePath.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo,
                                    size: 40, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('Tap to pick image',
                                    style: TextStyle(color: Colors.grey[600])),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _buildImage(currentImagePath),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Product Name
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                  SizedBox(height: 12),

                  // Description
                  TextField(
                      controller: descController,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      maxLines: 3),
                  SizedBox(height: 12),

                  // Price
                  TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(height: 12),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() => selectedCategory = newValue!);
                    },
                  ),

                  SizedBox(height: 12),

                  // Tag Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedProductTag,
                    decoration: InputDecoration(
                        labelText: 'Tag',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                    items: _tags.map((String tag) {
                      return DropdownMenuItem<String>(
                          value: tag, child: Text(tag));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() => selectedProductTag = newValue!);
                    },
                  ),

                  SizedBox(height: 12),

                  // Colors
                  TextField(
                      controller: colorsController,
                      decoration: InputDecoration(
                          labelText: 'Colors (comma separated)',
                          hintText: 'e.g. Red, Blue, Green',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                  SizedBox(height: 12),

                  // Sizes
                  TextField(
                      controller: sizesController,
                      decoration: InputDecoration(
                          labelText: 'Sizes (comma separated)',
                          hintText: 'e.g. S, M, L, XL',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                  SizedBox(height: 12),

                  // Stock
                  TextField(
                      controller: stockController,
                      decoration: InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      keyboardType: TextInputType.number),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              onPressed: () async {
                // Validation
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all required fields')),
                  );
                  return;
                }

                // Parse colors and sizes
                final colors = colorsController.text
                    .split(',')
                    .map((e) => '"${e.trim()}"')
                    .toList();
                final sizes = sizesController.text
                    .split(',')
                    .map((e) => '"${e.trim()}"')
                    .toList();

                // Create or update product
                if (isEditing) {
                  // Update existing product
                  final updatedProduct = product.copyWith(
                    name: nameController.text,
                    description: descController.text,
                    price: double.tryParse(priceController.text) ?? 0,
                    category: selectedCategory,
                    tag: selectedProductTag,
                    images: '["$currentImagePath"]',
                    colors: '[${colors.join(",")}]',
                    sizes: '[${sizes.join(",")}]',
                    stock: int.tryParse(stockController.text) ?? 0,
                  );
                  await widget.database.updateProduct(updatedProduct);
                } else {
                  // Insert new product
                  await widget.database.insertProduct(
                    ProductsCompanion.insert(
                      name: nameController.text,
                      description: descController.text,
                      price: double.tryParse(priceController.text) ?? 0,
                      category: selectedCategory,
                      tag: drift.Value(selectedProductTag),
                      images: '["$currentImagePath"]',
                      colors: '[${colors.join(",")}]',
                      sizes: '[${sizes.join(",")}]',
                      stock: int.tryParse(stockController.text) ?? 0,
                    ),
                  );
                }

                Navigator.pop(context);
                _loadProducts();
                widget.onProductsChanged();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(isEditing
                          ? 'Product updated successfully'
                          : 'Product added successfully')),
                );
              },
              child: Text(isEditing ? 'Update' : 'Add'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _deleteProduct(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await widget.database.deleteProduct(product.id);
      _loadProducts();
      widget.onProductsChanged();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Admin Panel', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen(database: widget.database)));
            },
          )
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined,
                      size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No products yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to add your first product',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final imagePath = product.images
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll('"', '');

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('\₱${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.tag,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            tooltip: 'Edit',
                            onPressed: () =>
                                _showAddEditDialog(product: product)),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Delete',
                            onPressed: () => _deleteProduct(product)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add button pressed'); // Debug line
          _showAddEditDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        tooltip: 'Add Product',
      ),
    );
  }
}
