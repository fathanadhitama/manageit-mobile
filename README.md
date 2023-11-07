# Manage.it
> Manage.it is a web application for shops to manage their sellings, records every transaction, look up shop's statistics and many more. This app is built with django

### Documentation:
- **[Tugas 7](#tugas-7)**<br>

***

# Tugas 7

##  Perbedaan utama antara stateless dan stateful widget dalam Flutter
1. Stateless Widget:
    - Stateless widget adalah widget yang tidak memiliki keadaan atau state internal. Mereka bersifat statis, artinya sekali dibangun, tampilan mereka tidak berubah selama sisa siklus hidup widget.
    - Stateless widget cocok untuk komponen yang tidak berubah dan tidak memerlukan pembaruan tampilan saat data berubah.
    - Contoh penggunaan stateless widget adalah teks statis, ikon, gambar, dan sebagainya.
2. Stateful Widget:
    - Stateful widget adalah widget yang dapat memiliki keadaan atau state internal yang dapat berubah sepanjang waktu. Mereka dirancang untuk situasi di mana tampilan perlu diperbarui saat ada perubahan dalam data atau interaksi pengguna.
    - Stateful widget mengandung dua bagian utama: widget itu sendiri (StatefulWidget) dan objek state yang terkait (State). State ini berisi data yang berubah dan dapat memicu pembaruan tampilan widget ketika diperlukan.
    - Contoh penggunaan stateful widget adalah tombol yang berubah warna saat ditekan, daftar item yang dapat diperbarui, dan formulir input.

  Jadi, perbedaan utama antara keduanya adalah dalam cara mereka mengelola keadaan. Stateless widget tidak memiliki keadaan internal, sementara stateful widget dapat mengelola keadaan internal dan merespons perubahan data atau interaksi pengguna.

## Widget dan fungsinya
1. MyHomePage (Stateless Widget): kelas yang mewakili halaman utama atau beranda dari aplikasi.
Mewarisi StatelessWidget, yang berarti tidak memiliki keadaan internal yang berubah.
2. Scaffold: widget yang memberikan kerangka untuk halaman Anda, termasuk AppBar dan body.
3. AppBar: widget di bagian atas halaman yang menampilkan judul aplikasi.
4. SingleChildScrollView: widget yang membungkus konten utama dan memungkinkan user untuk menggulir jika kontennya lebih panjang dari layar.
5. Padding: menambahkan jarak antara konten dengan border.
6. Column: widget untuk menampilkan children secara vertikal.
7. GridView.count: grid layout yang menampilkan item dalam bentuk grid dengan tiga kolom.
8. ShopItem: kelas yang mendefinisikan item toko, termasuk nama, ikon, dan warna.
9. ShopCard (Stateless Widget): widget yang digunakan untuk menampilkan setiap item toko dalam bentuk kartu (card).
Widget ini memiliki tap handler yang menampilkan snackbar saat diklik.
10. Material: widget yang memberikan latar belakang warna pada kartu.
11. InkWell: widget yang membuat area responsif terhadap sentuhan pengguna (tap). Ketika di-tap, akan menampilkan snackbar.
12. Container: widget yang digunakan untuk mengelompokkan ikon dan teks dalam card.
13. Icon: widget yang menampilkan ikon.
14. Text: widget yang menampilkan teks.
15. MyApp (Stateless Widget): kelas yang mewakili aplikasi Flutter dan mewarisi StatelessWidget, yang berarti tidak memiliki keadaan internal yang berubah.
16. MaterialApp: widget yang mendefinisikan kerangka dasar untuk aplikasi Flutter.
17. title: judul aplikasi yang akan ditampilkan di AppBar atau dalam daftar aplikasi.
18. theme: tema aplikasi yang digunakan untuk mengkustomisasi tampilan aplikasi. Dalam kode ini, tema diberikan menggunakan objek ThemeData.
19. ColorScheme: bagian dari tema dan digunakan untuk mengatur skema warna aplikasi, termasuk warna latar belakang dan teks.

## Implementasi Checklist
### 1. Membuat program flutter baru
- Buat proyek flutter baru dengan menjalankan perintah
```
flutter create manageit_mobile
```
- Untuk menjalankan proyek yang telah dibuat, jalankan perintah
```
cd manageit_mobile
flutter run
```
- Kemudian pilih browser untuk menjalankan program flutter tersebut
### 2. Membuat tombol daftar item, tambah item, dan logout
#### Rapikan struktur proyek
1. Buat file baru bernama `menu.dart` pada direktori `manageit_mobile/lib`, lalu tambahkan baris berikut:
```
import 'package:flutter/material.dart';
``` 

2. Dari file main.dart, pindahkan (cut) kode baris ke-39 hingga akhir yang berisi kedua class di bawah ini:
```
class MyHomePage ... {
    ...
}

class _MyHomePageState ... {
    ...
}
```
ke file menu.dart yang baru saja dibuat.

3. Kemudian, tambahkan kode berikut agar class `MyHomePage` dapat dikenali oleh kode dalam file `main.dart`
```
import 'package:manageit_mobile/menu.dart';
```

#### Buat widget sederhana
Pertama, ubah **sifat widget halaman menu menjadi stateless** dengan melakukan langkah berikut:
1. Pada file main.dart, hapus MyHomePage(title: 'Flutter Demo Home Page') sehingga menjadi:
```
MyHomePage()
```
2. Pada file menu.dart, kamu akan mengubah sifat widget halaman dari stateful menjadi stateless. Lakukan perubahan pada bagian ({super.key, required this.title}) menjadi ({Key? key}) : super(key: key);. Hapus final String title; sampai bawah serta tambahkan Widget build sehingga kode terlihat seperti di bawah.
```
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            ...
        );
    }
}
```
3. Jangan lupa untuk menghapus juga fungsi **State** yang ada dibawah bagian stateless widget ini

Setelah mengubah sifat widget halaman menu menjadi stateless, kita akan **menambahkan teks dan card** untuk memperlihatkan barang-barang.

1. Define tipe yang ada pada list
```
class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}
```
  Lalu dibawah kode `MyHomePage({Key? key}) : super(key: key);`, tambahkan list barang barang yang akan ditampilkan
```
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist),
    ShopItem("Tambah Item", Icons.add_shopping_cart),
    ShopItem("Logout", Icons.logout),
];
```

2. Buat satu lagi *widget stateless* baru untuk menampilkan card.
```
class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```


3. Selanjutnya, tambahkan kode berikut di dalam **Widget** build.
```
return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manage.it',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Manage.it', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((ShopItem item) {
                    // Iterasi untuk setiap item
                    return ShopCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
```

### 3. Memunculkan Snackbar ketika tombol ditekan
Untuk memunculkan Snackbar ketika tombol ditekan, tambahkan kode berikut pada bagian `child` di **Widget** build

```
return Material(
      ...

      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
      ...
```

### Bonus
Untuk mengganti warna yang berbeda untuk setiap item, lakukan langkah berikut:
1. Tambahkan instance variable baru bernama `color` pada class `ShopItem`
```
class ShopItem {
  final String name;
  final IconData icon;
  final MaterialColor color;

  ShopItem(this.name, this.icon, this.color);
}
```

2. Kemudian, tambahkan argumen untuk atribut `color` pada setiap item di list `items` yang sudah dibuat.
```
final List<ShopItem> items = [
      ShopItem("Lihat Item", Icons.checklist, Colors.red),
      ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.amber),
      ShopItem("Logout", Icons.logout, Colors.blue),
  ];
```

3. Setelah itu, ubah properti `color` pada `ShopCard` menjadi `item.color`.
```
@override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,

      ...
```
