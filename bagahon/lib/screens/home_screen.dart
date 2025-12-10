import 'package:flutter/material.dart';
import 'dart:io';
import '../database/database.dart';
import '../widgets/product_details_sheet.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  HomeScreen({required this.database});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  List<String> categories = [
    'All',
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

  List<String> tags = [
    'New Arrivals',
    'Flash Deals',
    'Just For You',
    'Best Rated',
    'Hot Picks'
  ];

  List<Product> products = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await widget.database.getAllProducts();
    setState(() {
      products = loadedProducts;
      _filterProducts();
    });
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        final matchesCategory =
            selectedCategory == 'All' || product.category == selectedCategory;
        final matchesSearch = product.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  List<Product> _getProductsByTag(String tag) {
    return filteredProducts.where((p) => p.tag == tag).toList();
  }

  void _showProductDetails(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsSheet(
        product: product,
        database: widget.database,
        onAddedToBag: () {
          _loadProducts(); // refresh after checkout
        },
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Center(child: Icon(Icons.image, size: 50, color: Colors.grey));
    }
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)),
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(child: Icon(Icons.error)),
      );
    }
  }

  Widget _buildSmallProductCard(Product product) {
    final imagePath = product.images
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '');

    return GestureDetector(
      onTap: () => _showProductDetails(product),
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 12),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: _buildImage(imagePath),
                ),
              ),
              // Product Info
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    product.stock > 0
                        ? Text(
                            '₱${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Out of Stock',
                            style: TextStyle(
                              fontSize: 14,
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
    );
  }

  Widget _buildTagSection(String tag) {
    final productsInTag = _getProductsByTag(tag);

    if (productsInTag.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tag,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Could navigate to a full view of this category
                },
                child: Text(
                  'See all',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: productsInTag.length,
            itemBuilder: (context, index) {
              return _buildSmallProductCard(productsInTag[index]);
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BAGAHON', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadProducts, // pull-to-refresh
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => _filterProducts(),
              ),
            ),

            // Horizontal ScrollView for Categories
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => selectedCategory = category);
                        _filterProducts();
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Colors.black,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

            // Tag Sections with horizontal scrolling products
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No products available',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children:
                            tags.map((tag) => _buildTagSection(tag)).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
