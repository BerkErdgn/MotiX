import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/entity/post.dart';
import 'package:motix_app/pages/cubit/addPostCubit.dart';
import 'package:uuid/uuid.dart'; // Benzersiz postId için

class AddBlogPostPage extends StatefulWidget {
  final Function(Post) onAdd;
  final String postOwnerEmail;
  final String postOwnerName;
  final String postOwnerProfileIcon;

  const AddBlogPostPage({super.key, required this.onAdd, required this.postOwnerEmail, required this.postOwnerName, required this.postOwnerProfileIcon});

  @override
  _AddBlogPostPageState createState() => _AddBlogPostPageState();
}

class _AddBlogPostPageState extends State<AddBlogPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = [
    'Trend',
    'Başarı',
    'Kariyer',
    'Motivasyon',
    'Gelişim',
    'Kitaplar',
    'Eğitim',
    'Zaman',
    'Hedefler',
    'İlham',
    'Özgüven'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yeni Gönderi Ekle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Başlık',
                  hintText: 'Gönderi başlığı girin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlık zorunludur.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Açıklama',
                  hintText: 'Gönderi açıklaması girin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Açıklama zorunludur.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text('Kategori seçin'),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var postId = Uuid().v4();
                    var postDate = DateTime.now().toIso8601String();

                    Post newPost = Post(
                      postId: postId,
                      postOwnerName: widget.postOwnerName,
                      postOwnerEmail: widget.postOwnerEmail,
                      postTitle: _titleController.text,
                      postDescription: _descriptionController.text,
                      postOwnerProfileIcon: widget.postOwnerProfileIcon,
                      postDate: postDate,
                      postCategories: [_selectedCategory!],
                    );

                    context.read<AddPostCubit>().addPost(
                      newPost.postId,
                      newPost.postOwnerName,
                      newPost.postOwnerEmail,
                      newPost.postTitle,
                      newPost.postDescription,
                      newPost.postOwnerProfileIcon,
                      newPost.postDate,
                      newPost.postCategories,
                    );

                    widget.onAdd(newPost);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.orange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                ),
                child: const Text(
                  'Gönderiyi Ekle',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
