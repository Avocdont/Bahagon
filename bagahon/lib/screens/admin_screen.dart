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

  // UPDATED: Removed 'All' from this list
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
          // Use standard padding
          insetPadding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEditing ? 'Edit Product' : 'Add Product',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            // UPDATED: Constrain width to 400
            constraints: BoxConstraints(maxWidth: 600),
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                                Text('Tap to pick image'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _buildImage(currentImagePath),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder())),
                  SizedBox(height: 12),
                  TextField(
                      controller: descController,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder()),
                      maxLines: 3),
                  SizedBox(height: 12),
                  TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Price', border: OutlineInputBorder()),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true)),
                  SizedBox(height: 12),

                  // Dropdown with "All" removed
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                        labelText: 'Category', border: OutlineInputBorder()),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() => selectedCategory = newValue!);
                    },
                  ),

                  SizedBox(height: 12),
                  TextField(
                      controller: colorsController,
                      decoration: InputDecoration(
                          labelText: 'Colors (comma separated)',
                          border: OutlineInputBorder())),
                  SizedBox(height: 12),
                  TextField(
                      controller: sizesController,
                      decoration: InputDecoration(
                          labelText: 'Sizes (comma separated)',
                          border: OutlineInputBorder())),
                  SizedBox(height: 12),
                  TextField(
                      controller: stockController,
                      decoration: InputDecoration(
                          labelText: 'Stock', border: OutlineInputBorder()),
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
                if (nameController.text.isEmpty || priceController.text.isEmpty)
                  return;

                final colors = colorsController.text
                    .split(',')
                    .map((e) => '"${e.trim()}"')
                    .toList();
                final sizes = sizesController.text
                    .split(',')
                    .map((e) => '"${e.trim()}"')
                    .toList();

                final prodData = isEditing
                    ? product.copyWith(
                        name: nameController.text,
                        description: descController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        category: selectedCategory,
                        images: '["$currentImagePath"]',
                        colors: '[${colors.join(",")}]',
                        sizes: '[${sizes.join(",")}]',
                        stock: int.tryParse(stockController.text) ?? 0,
                      )
                    : ProductsCompanion.insert(
                        name: nameController.text,
                        description: descController.text,
                        price: double.tryParse(priceController.text) ?? 0,
                        category: selectedCategory,
                        images: '["$currentImagePath"]',
                        colors: '[${colors.join(",")}]',
                        sizes: '[${sizes.join(",")}]',
                        stock: int.tryParse(stockController.text) ?? 0,
                      );

                if (isEditing) {
                  await widget.database.updateProduct(prodData as Product);
                } else {
                  await widget.database
                      .insertProduct(prodData as ProductsCompanion);
                }

                Navigator.pop(context);
                _loadProducts();
                widget.onProductsChanged();
              },
              child: Text(isEditing ? 'Update' : 'Add'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
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
                backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await widget.database.deleteProduct(product.id);
      _loadProducts();
      widget.onProductsChanged();
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
          ? Center(child: Text('No products'))
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
                    subtitle: Text('\$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _showAddEditDialog(product: product)),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteProduct(product)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
