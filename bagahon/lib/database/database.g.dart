// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, role, email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final String role;
  final String? email;
  const User(
      {required this.id,
      required this.username,
      required this.password,
      required this.role,
      this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      role: Value(role),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<String>(json['role']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<String>(role),
      'email': serializer.toJson<String?>(email),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? password,
          String? role,
          Value<String?> email = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        role: role ?? this.role,
        email: email.present ? email.value : this.email,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      role: data.role.present ? data.role.value : this.role,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, role, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.role == this.role &&
          other.email == this.email);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> role;
  final Value<String?> email;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
    this.email = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required String role,
    this.email = const Value.absent(),
  })  : username = Value(username),
        password = Value(password),
        role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? role,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
      if (email != null) 'email': email,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? role,
      Value<String?>? email}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagesMeta = const VerificationMeta('images');
  @override
  late final GeneratedColumn<String> images = GeneratedColumn<String>(
      'images', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorsMeta = const VerificationMeta('colors');
  @override
  late final GeneratedColumn<String> colors = GeneratedColumn<String>(
      'colors', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizesMeta = const VerificationMeta('sizes');
  @override
  late final GeneratedColumn<String> sizes = GeneratedColumn<String>(
      'sizes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('New Arrivals'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        price,
        category,
        images,
        colors,
        sizes,
        stock,
        tag
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images']!, _imagesMeta));
    } else if (isInserting) {
      context.missing(_imagesMeta);
    }
    if (data.containsKey('colors')) {
      context.handle(_colorsMeta,
          colors.isAcceptableOrUnknown(data['colors']!, _colorsMeta));
    } else if (isInserting) {
      context.missing(_colorsMeta);
    }
    if (data.containsKey('sizes')) {
      context.handle(
          _sizesMeta, sizes.isAcceptableOrUnknown(data['sizes']!, _sizesMeta));
    } else if (isInserting) {
      context.missing(_sizesMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      images: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}images'])!,
      colors: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}colors'])!,
      sizes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sizes'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String images;
  final String colors;
  final String sizes;
  final int stock;
  final String tag;
  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.category,
      required this.images,
      required this.colors,
      required this.sizes,
      required this.stock,
      required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    map['category'] = Variable<String>(category);
    map['images'] = Variable<String>(images);
    map['colors'] = Variable<String>(colors);
    map['sizes'] = Variable<String>(sizes);
    map['stock'] = Variable<int>(stock);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      price: Value(price),
      category: Value(category),
      images: Value(images),
      colors: Value(colors),
      sizes: Value(sizes),
      stock: Value(stock),
      tag: Value(tag),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      category: serializer.fromJson<String>(json['category']),
      images: serializer.fromJson<String>(json['images']),
      colors: serializer.fromJson<String>(json['colors']),
      sizes: serializer.fromJson<String>(json['sizes']),
      stock: serializer.fromJson<int>(json['stock']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'category': serializer.toJson<String>(category),
      'images': serializer.toJson<String>(images),
      'colors': serializer.toJson<String>(colors),
      'sizes': serializer.toJson<String>(sizes),
      'stock': serializer.toJson<int>(stock),
      'tag': serializer.toJson<String>(tag),
    };
  }

  Product copyWith(
          {int? id,
          String? name,
          String? description,
          double? price,
          String? category,
          String? images,
          String? colors,
          String? sizes,
          int? stock,
          String? tag}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        category: category ?? this.category,
        images: images ?? this.images,
        colors: colors ?? this.colors,
        sizes: sizes ?? this.sizes,
        stock: stock ?? this.stock,
        tag: tag ?? this.tag,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      price: data.price.present ? data.price.value : this.price,
      category: data.category.present ? data.category.value : this.category,
      images: data.images.present ? data.images.value : this.images,
      colors: data.colors.present ? data.colors.value : this.colors,
      sizes: data.sizes.present ? data.sizes.value : this.sizes,
      stock: data.stock.present ? data.stock.value : this.stock,
      tag: data.tag.present ? data.tag.value : this.tag,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('images: $images, ')
          ..write('colors: $colors, ')
          ..write('sizes: $sizes, ')
          ..write('stock: $stock, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, price, category,
      images, colors, sizes, stock, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.category == this.category &&
          other.images == this.images &&
          other.colors == this.colors &&
          other.sizes == this.sizes &&
          other.stock == this.stock &&
          other.tag == this.tag);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> price;
  final Value<String> category;
  final Value<String> images;
  final Value<String> colors;
  final Value<String> sizes;
  final Value<int> stock;
  final Value<String> tag;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.category = const Value.absent(),
    this.images = const Value.absent(),
    this.colors = const Value.absent(),
    this.sizes = const Value.absent(),
    this.stock = const Value.absent(),
    this.tag = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required double price,
    required String category,
    required String images,
    required String colors,
    required String sizes,
    required int stock,
    this.tag = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        price = Value(price),
        category = Value(category),
        images = Value(images),
        colors = Value(colors),
        sizes = Value(sizes),
        stock = Value(stock);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<String>? category,
    Expression<String>? images,
    Expression<String>? colors,
    Expression<String>? sizes,
    Expression<int>? stock,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (category != null) 'category': category,
      if (images != null) 'images': images,
      if (colors != null) 'colors': colors,
      if (sizes != null) 'sizes': sizes,
      if (stock != null) 'stock': stock,
      if (tag != null) 'tag': tag,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<double>? price,
      Value<String>? category,
      Value<String>? images,
      Value<String>? colors,
      Value<String>? sizes,
      Value<int>? stock,
      Value<String>? tag}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      stock: stock ?? this.stock,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    if (colors.present) {
      map['colors'] = Variable<String>(colors.value);
    }
    if (sizes.present) {
      map['sizes'] = Variable<String>(sizes.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('category: $category, ')
          ..write('images: $images, ')
          ..write('colors: $colors, ')
          ..write('sizes: $sizes, ')
          ..write('stock: $stock, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

class $LikesTable extends Likes with TableInfo<$LikesTable, Like> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _likedAtMeta =
      const VerificationMeta('likedAt');
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
      'liked_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, productId, likedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'likes';
  @override
  VerificationContext validateIntegrity(Insertable<Like> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('liked_at')) {
      context.handle(_likedAtMeta,
          likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta));
    } else if (isInserting) {
      context.missing(_likedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Like map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Like(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      likedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}liked_at'])!,
    );
  }

  @override
  $LikesTable createAlias(String alias) {
    return $LikesTable(attachedDatabase, alias);
  }
}

class Like extends DataClass implements Insertable<Like> {
  final int id;
  final int productId;
  final DateTime likedAt;
  const Like(
      {required this.id, required this.productId, required this.likedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  LikesCompanion toCompanion(bool nullToAbsent) {
    return LikesCompanion(
      id: Value(id),
      productId: Value(productId),
      likedAt: Value(likedAt),
    );
  }

  factory Like.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Like(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  Like copyWith({int? id, int? productId, DateTime? likedAt}) => Like(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        likedAt: likedAt ?? this.likedAt,
      );
  Like copyWithCompanion(LikesCompanion data) {
    return Like(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Like(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, likedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Like &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.likedAt == this.likedAt);
}

class LikesCompanion extends UpdateCompanion<Like> {
  final Value<int> id;
  final Value<int> productId;
  final Value<DateTime> likedAt;
  const LikesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.likedAt = const Value.absent(),
  });
  LikesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required DateTime likedAt,
  })  : productId = Value(productId),
        likedAt = Value(likedAt);
  static Insertable<Like> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<DateTime>? likedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (likedAt != null) 'liked_at': likedAt,
    });
  }

  LikesCompanion copyWith(
      {Value<int>? id, Value<int>? productId, Value<DateTime>? likedAt}) {
    return LikesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      likedAt: likedAt ?? this.likedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }
}

class $BagItemsTable extends BagItems with TableInfo<$BagItemsTable, BagItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BagItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _selectedColorMeta =
      const VerificationMeta('selectedColor');
  @override
  late final GeneratedColumn<String> selectedColor = GeneratedColumn<String>(
      'selected_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _selectedSizeMeta =
      const VerificationMeta('selectedSize');
  @override
  late final GeneratedColumn<String> selectedSize = GeneratedColumn<String>(
      'selected_size', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, selectedColor, selectedSize, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bag_items';
  @override
  VerificationContext validateIntegrity(Insertable<BagItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('selected_color')) {
      context.handle(
          _selectedColorMeta,
          selectedColor.isAcceptableOrUnknown(
              data['selected_color']!, _selectedColorMeta));
    } else if (isInserting) {
      context.missing(_selectedColorMeta);
    }
    if (data.containsKey('selected_size')) {
      context.handle(
          _selectedSizeMeta,
          selectedSize.isAcceptableOrUnknown(
              data['selected_size']!, _selectedSizeMeta));
    } else if (isInserting) {
      context.missing(_selectedSizeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BagItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BagItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      selectedColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_color'])!,
      selectedSize: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}selected_size'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $BagItemsTable createAlias(String alias) {
    return $BagItemsTable(attachedDatabase, alias);
  }
}

class BagItem extends DataClass implements Insertable<BagItem> {
  final int id;
  final int productId;
  final String selectedColor;
  final String selectedSize;
  final int quantity;
  const BagItem(
      {required this.id,
      required this.productId,
      required this.selectedColor,
      required this.selectedSize,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['selected_color'] = Variable<String>(selectedColor);
    map['selected_size'] = Variable<String>(selectedSize);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  BagItemsCompanion toCompanion(bool nullToAbsent) {
    return BagItemsCompanion(
      id: Value(id),
      productId: Value(productId),
      selectedColor: Value(selectedColor),
      selectedSize: Value(selectedSize),
      quantity: Value(quantity),
    );
  }

  factory BagItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BagItem(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      selectedColor: serializer.fromJson<String>(json['selectedColor']),
      selectedSize: serializer.fromJson<String>(json['selectedSize']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'selectedColor': serializer.toJson<String>(selectedColor),
      'selectedSize': serializer.toJson<String>(selectedSize),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  BagItem copyWith(
          {int? id,
          int? productId,
          String? selectedColor,
          String? selectedSize,
          int? quantity}) =>
      BagItem(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedSize: selectedSize ?? this.selectedSize,
        quantity: quantity ?? this.quantity,
      );
  BagItem copyWithCompanion(BagItemsCompanion data) {
    return BagItem(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      selectedColor: data.selectedColor.present
          ? data.selectedColor.value
          : this.selectedColor,
      selectedSize: data.selectedSize.present
          ? data.selectedSize.value
          : this.selectedSize,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BagItem(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, selectedColor, selectedSize, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BagItem &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.selectedColor == this.selectedColor &&
          other.selectedSize == this.selectedSize &&
          other.quantity == this.quantity);
}

class BagItemsCompanion extends UpdateCompanion<BagItem> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> selectedColor;
  final Value<String> selectedSize;
  final Value<int> quantity;
  const BagItemsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.selectedColor = const Value.absent(),
    this.selectedSize = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  BagItemsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String selectedColor,
    required String selectedSize,
    required int quantity,
  })  : productId = Value(productId),
        selectedColor = Value(selectedColor),
        selectedSize = Value(selectedSize),
        quantity = Value(quantity);
  static Insertable<BagItem> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? selectedColor,
    Expression<String>? selectedSize,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (selectedColor != null) 'selected_color': selectedColor,
      if (selectedSize != null) 'selected_size': selectedSize,
      if (quantity != null) 'quantity': quantity,
    });
  }

  BagItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<String>? selectedColor,
      Value<String>? selectedSize,
      Value<int>? quantity}) {
    return BagItemsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (selectedColor.present) {
      map['selected_color'] = Variable<String>(selectedColor.value);
    }
    if (selectedSize.present) {
      map['selected_size'] = Variable<String>(selectedSize.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BagItemsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('selectedColor: $selectedColor, ')
          ..write('selectedSize: $selectedSize, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemsMeta = const VerificationMeta('items');
  @override
  late final GeneratedColumn<String> items = GeneratedColumn<String>(
      'items', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, items, total, date, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('items')) {
      context.handle(
          _itemsMeta, items.isAcceptableOrUnknown(data['items']!, _itemsMeta));
    } else if (isInserting) {
      context.missing(_itemsMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      items: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}items'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String items;
  final double total;
  final DateTime date;
  final String status;
  const Transaction(
      {required this.id,
      required this.items,
      required this.total,
      required this.date,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['items'] = Variable<String>(items);
    map['total'] = Variable<double>(total);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      items: Value(items),
      total: Value(total),
      date: Value(date),
      status: Value(status),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      items: serializer.fromJson<String>(json['items']),
      total: serializer.fromJson<double>(json['total']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'items': serializer.toJson<String>(items),
      'total': serializer.toJson<double>(total),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
    };
  }

  Transaction copyWith(
          {int? id,
          String? items,
          double? total,
          DateTime? date,
          String? status}) =>
      Transaction(
        id: id ?? this.id,
        items: items ?? this.items,
        total: total ?? this.total,
        date: date ?? this.date,
        status: status ?? this.status,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      items: data.items.present ? data.items.value : this.items,
      total: data.total.present ? data.total.value : this.total,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('items: $items, ')
          ..write('total: $total, ')
          ..write('date: $date, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, items, total, date, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.items == this.items &&
          other.total == this.total &&
          other.date == this.date &&
          other.status == this.status);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> items;
  final Value<double> total;
  final Value<DateTime> date;
  final Value<String> status;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.items = const Value.absent(),
    this.total = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String items,
    required double total,
    required DateTime date,
    required String status,
  })  : items = Value(items),
        total = Value(total),
        date = Value(date),
        status = Value(status);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? items,
    Expression<double>? total,
    Expression<DateTime>? date,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (items != null) 'items': items,
      if (total != null) 'total': total,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? items,
      Value<double>? total,
      Value<DateTime>? date,
      Value<String>? status}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      items: items ?? this.items,
      total: total ?? this.total,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (items.present) {
      map['items'] = Variable<String>(items.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('items: $items, ')
          ..write('total: $total, ')
          ..write('date: $date, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $LikesTable likes = $LikesTable(this);
  late final $BagItemsTable bagItems = $BagItemsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, products, likes, bagItems, transactions];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  required String role,
  Value<String?> email,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<String> role,
  Value<String?> email,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> email = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            password: password,
            role: role,
            email: email,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            required String role,
            Value<String?> email = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            password: password,
            role: role,
            email: email,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  required double price,
  required String category,
  required String images,
  required String colors,
  required String sizes,
  required int stock,
  Value<String> tag,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<double> price,
  Value<String> category,
  Value<String> images,
  Value<String> colors,
  Value<String> sizes,
  Value<int> stock,
  Value<String> tag,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colors => $composableBuilder(
      column: $table.colors, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sizes => $composableBuilder(
      column: $table.sizes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get images => $composableBuilder(
      column: $table.images, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colors => $composableBuilder(
      column: $table.colors, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sizes => $composableBuilder(
      column: $table.sizes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);

  GeneratedColumn<String> get colors =>
      $composableBuilder(column: $table.colors, builder: (column) => column);

  GeneratedColumn<String> get sizes =>
      $composableBuilder(column: $table.sizes, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> images = const Value.absent(),
            Value<String> colors = const Value.absent(),
            Value<String> sizes = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<String> tag = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            description: description,
            price: price,
            category: category,
            images: images,
            colors: colors,
            sizes: sizes,
            stock: stock,
            tag: tag,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String description,
            required double price,
            required String category,
            required String images,
            required String colors,
            required String sizes,
            required int stock,
            Value<String> tag = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            description: description,
            price: price,
            category: category,
            images: images,
            colors: colors,
            sizes: sizes,
            stock: stock,
            tag: tag,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()>;
typedef $$LikesTableCreateCompanionBuilder = LikesCompanion Function({
  Value<int> id,
  required int productId,
  required DateTime likedAt,
});
typedef $$LikesTableUpdateCompanionBuilder = LikesCompanion Function({
  Value<int> id,
  Value<int> productId,
  Value<DateTime> likedAt,
});

class $$LikesTableFilterComposer extends Composer<_$AppDatabase, $LikesTable> {
  $$LikesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get likedAt => $composableBuilder(
      column: $table.likedAt, builder: (column) => ColumnFilters(column));
}

class $$LikesTableOrderingComposer
    extends Composer<_$AppDatabase, $LikesTable> {
  $$LikesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
      column: $table.likedAt, builder: (column) => ColumnOrderings(column));
}

class $$LikesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikesTable> {
  $$LikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);
}

class $$LikesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LikesTable,
    Like,
    $$LikesTableFilterComposer,
    $$LikesTableOrderingComposer,
    $$LikesTableAnnotationComposer,
    $$LikesTableCreateCompanionBuilder,
    $$LikesTableUpdateCompanionBuilder,
    (Like, BaseReferences<_$AppDatabase, $LikesTable, Like>),
    Like,
    PrefetchHooks Function()> {
  $$LikesTableTableManager(_$AppDatabase db, $LikesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LikesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<DateTime> likedAt = const Value.absent(),
          }) =>
              LikesCompanion(
            id: id,
            productId: productId,
            likedAt: likedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required DateTime likedAt,
          }) =>
              LikesCompanion.insert(
            id: id,
            productId: productId,
            likedAt: likedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LikesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LikesTable,
    Like,
    $$LikesTableFilterComposer,
    $$LikesTableOrderingComposer,
    $$LikesTableAnnotationComposer,
    $$LikesTableCreateCompanionBuilder,
    $$LikesTableUpdateCompanionBuilder,
    (Like, BaseReferences<_$AppDatabase, $LikesTable, Like>),
    Like,
    PrefetchHooks Function()>;
typedef $$BagItemsTableCreateCompanionBuilder = BagItemsCompanion Function({
  Value<int> id,
  required int productId,
  required String selectedColor,
  required String selectedSize,
  required int quantity,
});
typedef $$BagItemsTableUpdateCompanionBuilder = BagItemsCompanion Function({
  Value<int> id,
  Value<int> productId,
  Value<String> selectedColor,
  Value<String> selectedSize,
  Value<int> quantity,
});

class $$BagItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BagItemsTable> {
  $$BagItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$BagItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BagItemsTable> {
  $$BagItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$BagItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BagItemsTable> {
  $$BagItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get selectedColor => $composableBuilder(
      column: $table.selectedColor, builder: (column) => column);

  GeneratedColumn<String> get selectedSize => $composableBuilder(
      column: $table.selectedSize, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$BagItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BagItemsTable,
    BagItem,
    $$BagItemsTableFilterComposer,
    $$BagItemsTableOrderingComposer,
    $$BagItemsTableAnnotationComposer,
    $$BagItemsTableCreateCompanionBuilder,
    $$BagItemsTableUpdateCompanionBuilder,
    (BagItem, BaseReferences<_$AppDatabase, $BagItemsTable, BagItem>),
    BagItem,
    PrefetchHooks Function()> {
  $$BagItemsTableTableManager(_$AppDatabase db, $BagItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BagItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BagItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BagItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<String> selectedColor = const Value.absent(),
            Value<String> selectedSize = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              BagItemsCompanion(
            id: id,
            productId: productId,
            selectedColor: selectedColor,
            selectedSize: selectedSize,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productId,
            required String selectedColor,
            required String selectedSize,
            required int quantity,
          }) =>
              BagItemsCompanion.insert(
            id: id,
            productId: productId,
            selectedColor: selectedColor,
            selectedSize: selectedSize,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BagItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BagItemsTable,
    BagItem,
    $$BagItemsTableFilterComposer,
    $$BagItemsTableOrderingComposer,
    $$BagItemsTableAnnotationComposer,
    $$BagItemsTableCreateCompanionBuilder,
    $$BagItemsTableUpdateCompanionBuilder,
    (BagItem, BaseReferences<_$AppDatabase, $BagItemsTable, BagItem>),
    BagItem,
    PrefetchHooks Function()>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  required String items,
  required double total,
  required DateTime date,
  required String status,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<String> items,
  Value<double> total,
  Value<DateTime> date,
  Value<String> status,
});

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get items => $composableBuilder(
      column: $table.items, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get items => $composableBuilder(
      column: $table.items, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get items =>
      $composableBuilder(column: $table.items, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> items = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            items: items,
            total: total,
            date: date,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String items,
            required double total,
            required DateTime date,
            required String status,
          }) =>
              TransactionsCompanion.insert(
            id: id,
            items: items,
            total: total,
            date: date,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$LikesTableTableManager get likes =>
      $$LikesTableTableManager(_db, _db.likes);
  $$BagItemsTableTableManager get bagItems =>
      $$BagItemsTableTableManager(_db, _db.bagItems);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
