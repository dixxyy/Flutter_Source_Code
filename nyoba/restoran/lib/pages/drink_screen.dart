// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'menu_item.dart';

class DrinkScreen extends StatefulWidget {
  const DrinkScreen({super.key});

  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  List<MenuItem> menuItems = [
    MenuItem(name: 'Es Teh Manis', price: 5000),
    MenuItem(name: 'Es Jeruk', price: 4000),
    MenuItem(name: 'Jus Mangga', price: 7000),
    // Tambahkan item lain di sini
  ];

  List<MenuItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Minuman'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset('assets/gambar_minum${index + 1}.jpg'),
              title: Text(menuItem.name),
              subtitle: Text(
                  'Rp. ${menuItem.price.toStringAsFixed(0)}'), // Harga dalam rupiah
              trailing: Text('x ${menuItem.quantity}'),
              onTap: () {
                setState(() {
                  cartItems.add(menuItem);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(cartItems: cartItems)),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
