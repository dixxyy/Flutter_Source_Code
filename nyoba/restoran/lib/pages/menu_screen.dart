import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> menuItems = [
    MenuItem(name: 'Nasi Goreng', price: 15000),
    MenuItem(name: 'Mie Ayam', price: 12000),
    MenuItem(name: 'Soto Ayam', price: 10000),
    // Tambahkan item lain di sini
  ];

  List<MenuItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Makanan'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset('assets/gambar_menu${index + 1}.jpg'),
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
