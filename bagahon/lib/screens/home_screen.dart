import 'package:flutter/material.dart';
import '../database/database.dart';
import '../widgets/product_card.dart';
import '../widgets/product_details_sheet.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase database;

  HomeScreen({required this.database});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  // UPDATED: Full list of categories matching the Admin Panel
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

  void _showProductDetails(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsSheet(
        product: product,
        database: widget.database,
        onAddedToBag: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BAGAHON', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
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
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) => _filterProducts(),
            ),
          ),

          // UPDATED: Horizontal ScrollView for Categories
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
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
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16),

          // Product Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No products available',
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        database: widget.database,
                        onTap: () => _showProductDetails(product),
                        onLikeToggled: _loadProducts,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
