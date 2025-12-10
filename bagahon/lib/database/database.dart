import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

part 'database.g.dart';

// Tables
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get password => text()();
  TextColumn get role => text()(); // 'admin' or 'user'
  TextColumn get email => text().nullable()();
}

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get category => text()();
  TextColumn get images => text()();
  TextColumn get colors => text()();
  TextColumn get sizes => text()();
  IntColumn get stock => integer()();
  TextColumn get tag =>
      text().withDefault(const Constant('New Arrivals'))(); // ADD THIS LINE
}

class Likes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  DateTimeColumn get likedAt => dateTime()();
}

class BagItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  TextColumn get selectedColor => text()();
  TextColumn get selectedSize => text()();
  IntColumn get quantity => integer()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get items => text()();
  RealColumn get total => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text()();
}

@DriftDatabase(tables: [Users, Products, Likes, BagItems, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // CHANGE THIS FROM 1 TO 2

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'ecommerce_v3.sqlite'));
      return NativeDatabase(file);
    });
  }

  // --- MIGRATION STRATEGY ---
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll(); // Creates all tables
        },
        onUpgrade: (m, from, to) async {
          // Migrate from version 1 to 2
          if (from == 1 && to == 2) {
            // Add the tag column to products table
            await m.addColumn(products, products.tag);
          }
        },
        beforeOpen: (details) async {
          // Optional: any logic to run before opening database
        },
      );

  // --- SEED ADMIN METHOD (Silent) ---
  Future<void> seedDefaultAdmin() async {
    final admin = await (select(users)
          ..where((u) => u.username.equals('admin')))
        .getSingleOrNull();
    if (admin == null) {
      await into(users).insert(
        UsersCompanion.insert(
          username: 'admin',
          password: 'admin123',
          role: 'admin',
          email: const Value('admin@store.com'),
        ),
      );
    }
  }

  // Auth Methods
  Future<User?> login(String username, String password) {
    return (select(users)
          ..where(
              (u) => u.username.equals(username) & u.password.equals(password)))
        .getSingleOrNull();
  }

  Future<int> registerUser(UsersCompanion user) => into(users).insert(user);

  // Products CRUD
  Future<List<Product>> getAllProducts() => select(products).get();
  Future<List<Product>> getProductsByCategory(String category) =>
      (select(products)..where((p) => p.category.equals(category))).get();
  Future<Product> getProductById(int id) =>
      (select(products)..where((p) => p.id.equals(id))).getSingle();
  Future<int> insertProduct(ProductsCompanion product) =>
      into(products).insert(product);
  Future<bool> updateProduct(Product product) =>
      update(products).replace(product);
  Future<int> deleteProduct(int id) =>
      (delete(products)..where((p) => p.id.equals(id))).go();

  // Likes
  Future<List<Like>> getAllLikes() => select(likes).get();
  Future<int> insertLike(LikesCompanion like) => into(likes).insert(like);
  Future<int> deleteLike(int productId) =>
      (delete(likes)..where((l) => l.productId.equals(productId))).go();
  Future<bool> isLiked(int productId) async {
    final result = await (select(likes)
          ..where((l) => l.productId.equals(productId)))
        .get();
    return result.isNotEmpty;
  }

  // Bag
  Future<List<BagItem>> getAllBagItems() => select(bagItems).get();
  Future<int> insertBagItem(BagItemsCompanion item) =>
      into(bagItems).insert(item);
  Future<bool> updateBagItem(BagItem item) => update(bagItems).replace(item);
  Future<int> deleteBagItem(int id) =>
      (delete(bagItems)..where((b) => b.id.equals(id))).go();
  Future<int> clearBagItems(List<int> ids) =>
      (delete(bagItems)..where((b) => b.id.isIn(ids))).go();

  // Transactions
  Future<List<Transaction>> getAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.date)])).get();
  Future<int> insertTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);
}
