// ignore_for_file: no_logic_in_create_state, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'menu_item.dart';

class CartScreen extends StatefulWidget {
  final List<MenuItem> cartItems;

  CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
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
        title: Text('Keranjang Pembellian'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                cartItems.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset('assets/gambar_menu${index + 1}.jpg'),
                title: Text(cartItem.name),
                subtitle: Text('Rp. ${cartItem.price.toStringAsFixed(0)}'),
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
              Text('Total: Rp. ${calculateTotal().toStringAsFixed(0)}'),
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
                            CircularProgressIndicator(),
                            SizedBox(height: 16.0),
                            Text('Sedang memproses pembayaran...'),
                          ],
                        ),
                      );
                    },
                  );

                  // Tambahkan logika pembayaran di sini

                  // Setelah pembayaran selesai, tutup dialog loading dan kosongkan keranjang
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pembayaran berhasil!'),
                      ),
                    );

                    // Kosongkan keranjang belanja
                    setState(() {
                      cartItems.clear();
                    });
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

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Berhasil'),
          content: Text('Terima kasih atas pembayaran Anda.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
