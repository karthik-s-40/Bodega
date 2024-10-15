import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'dart:io';

part 'database.g.dart';

// Address table
@DataClassName('Address')
class Addresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  TextColumn get roadStreet => text().withLength(min: 1, max: 255)();
  TextColumn get district => text().withLength(min: 1, max: 100)();
  TextColumn get pincode => text().withLength(min: 1, max: 20)();
}

// Cart table
@DataClassName('CartItem')
class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text().withLength(min: 1, max: 100)();
  RealColumn get price => real()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
}

// The main database class
@DriftDatabase(tables: [Addresses, CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD operations for Addresses
  Future<int> addAddress(Address address) => into(addresses).insert(address);
  Future<List<Address>> getAllAddresses() => select(addresses).get();
  Future<int> deleteAddress(int id) => (delete(addresses)..where((tbl) => tbl.id.equals(id))).go();
  Future<String> getAddressAsString(int id) async {
  final address = await (select(addresses)..where((tbl) => tbl.id.equals(id))).getSingle();
  
  if (address == null) {
    return "Address not found";
  }
  
  // Create a formatted string from the address fields
  return '${address.name},${address.roadStreet}, ${address.district}, ${address.pincode}';
}

  // CRUD operations for CartItems
  Future<int> addCartItem(CartItem item) => into(cartItems).insert(item);
  Future<List<CartItem>> getAllCartItems() => select(cartItems).get();
  Future<int> updateCartItemQuantity(int id, int quantity) {
    return (update(cartItems)..where((tbl) => tbl.id.equals(id)))
        .write(CartItemsCompanion(quantity: Value(quantity)));
  }
  Future<int> deleteCartItem(int id) => (delete(cartItems)..where((tbl) => tbl.id.equals(id))).go();
}

// Connection to the SQLite database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/app_database.sqlite');
    return NativeDatabase(file);
  });
}
