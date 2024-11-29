import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  //variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
    // Memanggil fungsi fech data buku
  }

  // Fungsi fetch data buku
  Future fetchBooks() async {
    final response = await Supabase.instance.client.from('books').select();

    setState(() {
      books = List<Map<String, dynamic>>.from(response);
      // id = List<Map<Int, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Material(
          elevation: 4.0, // Atur nilai elevasi untuk bayangan
          child: AppBar(
            title: Text(
              'Gigital Library',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true, // Atur posisi judul di tengah
            backgroundColor: Colors.amber[400],
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: fetchBooks,
              ),
            ],
          ),
        ),
      ),
      body: books.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Menampilkan loading indicator
          : ListView.builder(
              padding: const EdgeInsets.all(16.0), // Menambahkan padding
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0), // Margin antar card
                  elevation: 4, // Efek bayangan
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.all(16.0), // Padding di dalam ListTile
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber[400],
                      child: Text(
                        book['id'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      book['title'] ?? 'No Title',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['author'] ?? 'Unknown Author',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 4), // Jarak antara teks
                        Text(
                          book['description'] ?? 'No Description',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[400]),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[400]),
                          onPressed: () {
                            // Delete book
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Book'),
                                  content: const Text(
                                      'Are you sure you want to delete this book?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () async {
                                        // await deleteBook(book['id']);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
