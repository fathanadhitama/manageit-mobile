import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:manageit_mobile/models/items.dart';
import 'package:manageit_mobile/screens/menu.dart';
import 'package:manageit_mobile/widgets/left_drawer.dart';

class ItemDetailPage extends StatefulWidget {
    final int itemID;
    const ItemDetailPage({Key? key, required this.itemID}) : super(key: key);

    @override
    _ItemDetailPageState createState() => _ItemDetailPageState(itemID: itemID);
}

class _ItemDetailPageState extends State<ItemDetailPage> {
    final int itemID;

    _ItemDetailPageState({required this.itemID});
Future<List<Item>> getItem() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        // 'http://127.0.0.1:8000/json/${this.itemID}/');
        'https://fathan-naufal-tugas.pbp.cs.ui.ac.id/json/$itemID/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Item> list_item = [];
    for (var d in data) {
        if (d != null) {
            list_item.add(Item.fromJson(d));
        }
    }
    return list_item;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: getItem(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () async {
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
                          },
                          child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20.0), // Set the border radius here
                                ),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Kategori: ${snapshot.data![index].fields.category}"),
                                    const SizedBox(height: 10),
                                    Text("Price: Rp${snapshot.data![index].fields.price}"),
                                    const SizedBox(height: 10),
                                    Text("Amount: ${snapshot.data![index].fields.amount}"),
                                    const SizedBox(height: 10),
                                    Text("Deskripsi:\n${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ),
                        )
                        );
                    }
                }
            }));
    }
}

