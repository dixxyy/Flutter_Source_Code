// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:restoran/pages/drink_screen.dart';
import 'package:restoran/pages/menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Function to show the table number input dialog
  void _showTableNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nomor Meja'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Masukkan nomor meja:'),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Nomor Meja'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                // Handle the table number input here
                // You can access the input value using a TextEditingController
                // For example: tableNumberController.text
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kantin Hijrah App'),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Container(
            width: 250,
            height: 100,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 163, 163, 167),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 75, top: 25),
              child: ListTile(
                title: Text('Makanan'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 250,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 75, top: 25),
              child: ListTile(
                title: Text('Minuman'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrinkScreen(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showTableNumberDialog(context);
              },
              child: Text('Pilih Nomor Meja'),
            ),
          ],
        ),
      ),
    );
  }
}
