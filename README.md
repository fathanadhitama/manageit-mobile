# Manage.it
> Manage.it is a web application for shops to manage their sellings, records every transaction, look up shop's statistics and many more. This app is built with django

### Documentation:
- **[Tugas 7](#tugas-7)**<br>
- **[Tugas 8](#tugas-8)**<br>

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

***

# Tugas 8

## Perbedaan Navigator.push() dan Navigator.pushReplacement()
Walaupun `push()` dan `pushReplacement()` sekilas terlihat mirip, namun perbedaan kedua method tersebut terletak pada apa yang dilakukan kepada route yang berada pada atas stack. `push()` akan menambahkan route baru diatas route yang sudah ada pada atas stack, sedangkan `pushReplacement()` menggantikan route yang sudah ada pada atas stack dengan route baru tersebut.
- `Navigator.push()` digunakan ketika kita ingin menambahkan halaman baru ke dalam tumpukan navigasi dan membiarkan pengguna kembali ke halaman sebelumnya.
- `Navigator.pushReplacement()` digunakan ketika kita ingin menggantikan halaman saat ini dengan halaman baru dan tidak ingin menyimpan halaman saat ini di tumpukan.

## Layout widgets
1. **Single-child layout widgets**

| Layout    | Usage |
| -------- | ------- |
| Container  | Model kotak yang dapat berisi widget lain. |
| Center | untuk menempatkan widget anak di tengah-tengah dirinya |
| Align    | untuk menempatkan widget anak di dalamnya dengan menggunakan `FractionalOffset`. |
| FittedBox    | untuk menyesuaikan dan menempatkan widget anak di dalamnya. |
| AspectRatio    | untuk memberikan rasio aspek tertentu pada widget anaknya.|
| FractionallySizedBox | untuk memberikan ukuran widget anak sebagai pecahan dari total ruang yang tersedia |
| IntrinsicHeight & IntrinsicWidth | untuk memberikan ukuran widget anak sesuai dengan tinggi atau lebar intrinsiknya |
| LimitedBox  | untuk membatasi tinggi atau lebar maksimum dari widget anaknya |
| ConstrainedBox  | untuk memberikan batasan ukuran (constraints) pada widget anaknya. |
| CustomSingleChildLayout  | memungkinkan membuat tata letak kustom untuk satu widget anak. |
| Expanded  | untuk mengisi sebanyak mungkin ruang yang tersedia di dalam widget parentnya. |
| Padding  | untuk menambahkan ruang bantal (padding) di sekitar widget anaknya. |
| Offstage  | untuk menyembunyikan atau menampilkan widget anak tanpa menghapusnya dari widget tree |
| OverflowBox  | untuk memungkinkan widget anak keluar dari batas-batas widget parentnya. |
| SizedOverflowBox  | memungkinkan widget anak memiliki ukuran yang berbeda dari batas-batas widget parentnya |
| Transform  | untuk menerapkan transformasi seperti translasi, rotasi, dan scaling pada widget anaknya |

2. **Multi-child layout widgets**

| Layout    | Usage |
| -------- | ------- |
| Row & Column  | untuk menyusun widget secara horizontal (Row) atau vertikal (Column) |
| ListView | digunakan untuk menampilkan daftar item yang dapat di-scroll |
| GridView    | untuk menampilkan widget dalam bentuk grid |
| Flow | menyusun widget anaknya dengan algoritma flow, memungkinkan tata letak yang dinamis dan responsif |
| Wrap | untuk menyusun widget anaknya dalam baris atau kolom, tetapi memindah ke baris atau kolom baru jika tidak cukup ruang |
| IndexedStack | menumpuk semua widget anak, tetapi hanya satu yang terlihat pada satu waktu berdasarkan indeks |
| Table | untuk menyusun widget dalam bentuk tabel dengan baris dan kolom |
| Stack  | untuk menumpuk widget anaknya satu di atas yang lain |
| LayoutBuilder  | Membangun widget sesuai dengan batasan tata letak (constraints) yang diberikan oleh widget parentnya. Menggunakan `Builder` yang memberikan konteks dan constraints untuk membangun widget. |
| CustomMultiChildLayout | Membuat tata letak kustom untuk beberapa widget anak. Perlu mengimplementasikan metode `performLayout` untuk menentukan posisi dan ukuran masing-masing widget anak |
| ListBody | mengatur widget anaknya dalam bentuk list tanpa perlu menggunakan `ListView`. Mendistribusikan ruang secara seimbang di antara widget anak. |

3. Sliver widgets

| Layout    | Usage |
| -------- | ------- |
| SliverAppBar  | elemen AppBar yang mengikuti aturan scrolling |
| SliverList | versi scrollable dari `ListView`, dirancang untuk digunakan dalam `CustomScrollView` |
| SliverGrid | versi scrollable dari `GridView`, dirancang untuk digunakan dalam `CustomScrollView`. |
| SliverToBoxAdapter | menyisipkan widget non-sliver ke dalam daftar sliver. |

## Elemen input

Elemen input yang saya pakai pada form yang ada di tugas ini hanya `TextFormField` dengan validasi input tertentu. Saya menggunakan elemen input tersebut karena isi formnya mengharuskan pengguna untuk mengetik sendiri semua data-data yang dibutuhkan, dan `TextFormField` merupakan elemen yang paling cocok untuk tujuan tersebut. Untuk melengkapi fungsionalitasnya, saya menambahkan `inputFormatters` untuk memvalidasi input yang dimasukkan user.

## Clean architecture

Dalam Flutter, implementasi Clean Architecture dapat melibatkan pembagian kode ke dalam tiga lapisan utama: Presenter (atau ViewModel di Flutter), Use Case, dan Repository. Ini memisahkan logika bisnis dari kerangka UI dan infrastruktur.

1. Presenter: 
    - Bertanggung jawab untuk logika tampilan dan interaksi pengguna.
    - Menggunakan model untuk menampung dan memanipulasi data yang akan ditampilkan.
2. Use Case:
    - Mengekstrak dan memproses data dari repository.
    - Mengandung aturan bisnis dan logika aplikasi.
3. Repository:
    - Berkomunikasi dengan sumber daya eksternal seperti API atau database.
    - Menyediakan data yang dibutuhkan oleh use case.

## Langkah-langkah implementasi

### Halaman formulir tambah item
1. Membuat file baru bernama `additem_form.dart` dan tambahkan kode berikut.
```
import 'package:flutter/material.dart';

class ShopFormPage extends StatefulWidget {
    const ShopFormPage({super.key});

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {

    @override
    Widget build(BuildContext context) {
        return Placeholder();
    }
}
```
2. Ubah widget Placeholder dengan kode berikut.
```
Scaffold(
  appBar: AppBar(
    title: const Center(
      child: Text(
        'Form Tambah Produk',
      ),
    ),
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // TODO: Tambahkan drawer yang sudah dibuat di sini
  body: Form(
    child: SingleChildScrollView()
  ),
);
```
3. Buat variabel baru bernama _formKey lalu tambahkan _formKey tersebut ke dalam atribut key milik widget Form. Atribut key akan berfungsi sebagai handler dari form state, validasi form, dan penyimpanan form.
```
...
class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
...
```

```
...
body: Form(
     key: _formKey,
     child: SingleChildScrollView(),
),
...
```
4. Buat variable untuk menyimpan input dari masing-masing field yang akan dibuat.
```
...
class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    String _category = "";
    int _amount = 0;
    int _price = 0;
    String _description = "";
    ...
```
5. Buat widget Column sebagai child dari SingleChildScrollView.
```
...
body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column()
      )
...
```
6. Buat widget TextFormField yang dibungkus oleh Padding sebagai salah satu children dari widget Column. Setelah itu, tambahkan atribut crossAxisAlignment untuk mengatur alignment children dari Column.
```
child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Nama Item",
            labelText: "Nama Item",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: (String? value) {
            setState(() {
              _name = value!;
            });
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Nama tidak boleh kosong!";
            }
            return null;
          },
        ),
      ),
```
> Ulangi langkah ini untuk setiap field yang dibutuhkan untuk input.

> Bagian validator akan memastikan input tidak dapat kosong
7. Untuk data yang bertipe integer, tambahkan kode berikut untuk memastikan inputnya berisi data integer.
```
...
 keyboardType: TextInputType.number,
inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
  // Hanya menerima input digit
],
// TODO: Tambahkan variabel yang sesuai
onChanged: (String? value) {
  setState(() {
    _amount = int.parse(value!);
  });
},
...
```
8. Buatlah tombol sebagai child selanjutnya dari Column. Bungkus tombol ke dalam widget Padding dan Align. Kali ini kita tidak akan menyimpan data ke dalam database, namun kita akan memunculkannya pada pop-up yang akan muncul setelah tombol ditekan
```
...
Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.indigo),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
),
...
```
### Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.

1. Pada `menu.dart`, import file halaman formulir yang telah dibuat.
```
import 'package:manageit_mobile/screens/additem_form.dart';
```
2. Di bawah bagian `ScaffoldMessenger`, tambahkan kode berikut untuk menambahkan navigasi ke halaman formulir yang sudah dibuat.
```
onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
            
          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Item") {
            // TODO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ShopFormPage(),
            ));
          }
        },
```

### Memunculkan data dalam popup
1. Tambahkan fungsi showDialog() pada bagian onPressed() dan munculkan widget AlertDialog pada fungsi tersebut. Kemudian, tambahkan juga fungsi untuk reset form.
```
...
child: ElevatedButton(
  style: ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(Colors.indigo),
  ),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Produk berhasil tersimpan'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Nama: $_name'),
                  Text('Category: $_category'),
                  Text('Price: $_price'),
                  Text('Amount: $_amount'),
                  Text('Description: $_description'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    _formKey.currentState!.reset();
    }
  },
  child: const Text(
    "Save",
    style: TextStyle(color: Colors.white),
  ),
),
...
```

### Membuat drawer
1. Buatlah berkas baru di dalam direktori baru widgets dengan nama `left_drawer.dart`. Tambahkan kode berikut ke dalam berkas `left_drawer.dart`.
```
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
          ),
          // TODO: Bagian routing
        ],
      ),
    );
  }
}
```
2. Berikutnya, tambahkan impor untuk halaman-halaman yang kita ingin masukkan navigasinya ke dalam Drawer Menu
```
import 'package:flutter/material.dart';
import 'package:manageit_mobile/screens/additem_form.dart';
import 'package:manageit_mobile/screens/menu.dart';
```

3. Setelah berhasil impor, kita akan memasukkan routing untuk halaman-halaman yang kita impor ke bagian `TODO: Bagian routing`.
```
// TODO: Bagian routing
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Halaman Utama'),
  // Bagian redirection ke MyHomePage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
),
ListTile(
  leading: const Icon(Icons.add_shopping_cart),
  title: const Text('Tambah Item'),
  // Bagian redirection ke ShopFormPage
  onTap: () {
    /*
    TODO: Buatlah routing ke ShopFormPage di sini,
    setelah halaman ShopFormPage sudah dibuat.
    */
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ShopFormPage(),
        ));
  },
),
```
4. Selanjutnya, tambahkan dekorasi untuk bagian header drawer.
```
const DrawerHeader(
  // TODO: Bagian drawer header
  decoration: BoxDecoration(
    color: Colors.black,
  ),
  child: Column(
    children: [
      Text(
        'Manage.it',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Padding(padding: EdgeInsets.all(10)),
      Text("Start manage it!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
    ],
  ),
),
```
5. Terakhir, masukkan drawer ke halaman `menu.dart` dan `additem_form.dart`.

menu.dart
```
...
// Impor drawer widget
import 'package:shopping_list/widgets/left_drawer.dart';
...
return Scaffold(
  appBar: AppBar(
  title: const Text(
    'Manage.it',
    style: TextStyle(color: Colors.white),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  backgroundColor: Colors.black,
),
drawer: const LeftDrawer(),
...
```
additem_form.dart
```
...
// TODO: Impor drawer yang sudah dibuat sebelumnya
import 'package:manageit_mobile/widgets/left_drawer.dart';
...

return Scaffold(
appBar: AppBar(
  title: const Center(
    child: Text(
      'Form Tambah Produk',
    ),
  ),
  backgroundColor: Colors.black,
  foregroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
),
// TODO: Tambahkan drawer yang sudah dibuat di sini
drawer: const LeftDrawer(),
...
```
