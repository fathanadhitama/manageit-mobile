import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:manageit_mobile/models/items.dart';
import 'package:manageit_mobile/screens/item_detail.dart';
import 'package:manageit_mobile/screens/menu.dart';
import 'package:manageit_mobile/screens/login.dart';
import 'package:manageit_mobile/widgets/left_drawer.dart';

class ItemPage extends StatefulWidget {
    const ItemPage({Key? key}) : super(key: key);

    @override
    _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
Future<List<Item>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        // 'http://127.0.0.1:8000/json/'
        'https://fathan-naufal-tugas.pbp.cs.ui.ac.id/json/'
        );
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
            Item item = Item.fromJson(d);
            if(item.fields.user == loggedInUser?.id){
              list_item.add(item);
            }
        }
    }
    return list_item;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Product Detail'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
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
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailPage(itemID: snapshot.data![index].pk,),
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
                                    Text("${snapshot.data![index].fields.price}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
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

