import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MenuItem {
  String name;
  double price;
  int quantity;

  MenuItem({required this.name, required this.price, this.quantity = 1});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> menuItems = [
    MenuItem(name: 'Nasi Goreng', price: 5000),
    MenuItem(name: 'Mie Ayam', price: 6000),
    // Tambahkan item lain di sini
  ];

  List<MenuItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Restoran'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
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

class CartScreen extends StatefulWidget {
  final List<MenuItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _CartScreenState createState() => _CartScreenState(cartItems: cartItems);
}

class _CartScreenState extends State<CartScreen> {
  List<MenuItem> cartItems;

  _CartScreenState({required this.cartItems});

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Dismissible(
            key:
                UniqueKey(), // Menggunakan UniqueKey untuk memastikan kunci unik
            onDismissed: (direction) {
              setState(() {
                cartItems.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(cartItem.name),
                subtitle: Text(
                    'Rp. ${cartItem.price.toStringAsFixed(0)}'), // Harga dalam rupiah
                trailing: Text('x ${cartItem.quantity}'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  'Total: Rp. ${calculateTotal().toStringAsFixed(0)}'), // Total harga dalam rupiah
              ElevatedButton(
                onPressed: () {
                  // Simulasikan tindakan pembayaran
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(), // Tambahkan loading lingkaran di sini
                            SizedBox(height: 16.0),
                            Text('Sedang memproses pembayaran...'),
                          ],
                        ),
                      );
                    },
                  );

                  // Tambahkan logika pembayaran di sini

                  // Setelah pembayaran selesai, tutup dialog loading
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pembayaran berhasil!'),
                      ),
                    );
                  });
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
