import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/entity/post.dart';
import 'package:motix_app/cubit/addPostCubit.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import 'package:uuid/uuid.dart';

class AddBlogPostPage extends StatefulWidget {
  final Function(Post) onAdd;
  final String postOwnerEmail;
  final String postOwnerName;
  final String postOwnerProfileIcon;

  const AddBlogPostPage(
      {super.key,
      required this.onAdd,
      required this.postOwnerEmail,
      required this.postOwnerName,
      required this.postOwnerProfileIcon});

  @override
  _AddBlogPostPageState createState() => _AddBlogPostPageState();
} // end class AddBlogPostPage

class _AddBlogPostPageState extends State<AddBlogPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  // category data
  final List<String> _categories = [
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
        title: Text(
          AddBlogPostStrings.pageTitle,
          style: const TextStyle(
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
                  labelText: AddBlogPostStrings.titleLabel,
                  hintText: AddBlogPostStrings.titleHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: MotixColor.mainColorOrange, width: 2.0),
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
                  labelText: AddBlogPostStrings.descriptionLabel,
                  hintText: AddBlogPostStrings.descriptionHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: MotixColor.mainColorOrange, width: 2.0),
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
                hint: Text(AddBlogPostStrings.categoryHintText),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: MotixColor.mainColorDarkGrey),
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
                items: _categories
                    .map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                          color: MotixColor.mainColorWhite, fontSize: 18),
                    ),
                  );
                }).toList(),
                dropdownColor: MotixColor.mainColorDarkGrey,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Post newPost = Post(
                      postId: Uuid().v4(),
                      postOwnerName: widget.postOwnerName,
                      postOwnerEmail: widget.postOwnerEmail,
                      postTitle: _titleController.text,
                      postDescription: _descriptionController.text,
                      postOwnerProfileIcon: widget.postOwnerProfileIcon,
                      postDate: Timestamp.now(),
                      postCategories: [_selectedCategory!],
                    );

                    context.read<AddPostCubit>().addPost(
                          newPost.postOwnerName,
                          newPost.postOwnerEmail,
                          newPost.postTitle,
                          newPost.postDescription,
                          newPost.postOwnerProfileIcon,
                          newPost.postCategories,
                        );

                    widget.onAdd(newPost);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      MotixColor.mainColorOrange),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 50),
                  ),
                ),
                child: Text(
                  AddBlogPostStrings.addButtonText,
                  style: const TextStyle(
                      fontSize: 18, color: MotixColor.mainColorWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} // end class _AddBlogPostPageState
