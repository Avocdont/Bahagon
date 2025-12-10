import 'dart:convert';
import 'package:flutter/material.dart';
import '../database/database.dart';

class TransactionsScreen extends StatefulWidget {
  final AppDatabase database;

  TransactionsScreen({required this.database});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final loadedTransactions = await widget.database.getAllTransactions();
    setState(() {
      transactions = loadedTransactions;
    });
  }

  void _showTransactionDetails(Transaction transaction) {
    // TODO: Implement details modal or navigation
  }

  String formatPrice(double value) {
    return '₱${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Transactions', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final items = jsonDecode(transaction.items) as List;

                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => _showTransactionDetails(transaction),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order #${transaction.id}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  transaction.status,
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Items count
                          Text(
                            '${items.length} item${items.length > 1 ? 's' : ''}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),

                          // Date
                          Text(
                            transaction.date.toString().split('.')[0],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Total row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                formatPrice(transaction.total), // ✅ fixed
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
