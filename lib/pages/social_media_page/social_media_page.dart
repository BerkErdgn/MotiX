import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/data/entity/userImageEntity.dart';
import 'package:motix_app/pages/cubit/imageCubit.dart';
import 'package:motix_app/pages/social_media_page/add_blog_post_page.dart';
import 'package:motix_app/pages/social_media_page/blog_post.dart';
import 'package:motix_app/pages/social_media_page/category_item.dart';
import 'package:motix_app/product/components/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  List<Map<String, dynamic>> categories = [
    {'label': 'Trend', 'icon': "assets/categoryIcons/trending.png"},
    {'label': 'Başarı', 'icon': 'assets/categoryIcons/success.png'},
    {'label': 'Kariyer', 'icon': "assets/categoryIcons/career.png"},
    {'label': 'Motivasyon', 'icon': "assets/categoryIcons/motivation.png"},
    {'label': 'Gelişim', 'icon': "assets/categoryIcons/hard-work.png"},
    {'label': 'Kitaplar', 'icon': "assets/categoryIcons/books.png"},
    {'label': 'Eğitim', 'icon': "assets/categoryIcons/education.png"},
    {'label': 'Zaman', 'icon': "assets/categoryIcons/time.png"},
    {'label': 'Hedefler', 'icon': "assets/categoryIcons/goal.png"},
    {'label': 'İlham', 'icon': "assets/categoryIcons/inspiration.png"},
    {'label': 'Özgüven', 'icon': "assets/categoryIcons/self-confidence.png"},
  ];
  String selectedCategory = 'Trend';
  List<BlogPost> blogPosts = [];

  //İmage için
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    _loadBlogPosts();
    context.read<Imagecubit>().getUserImage(user?.email ?? "");
  }

  void _loadBlogPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsJson = prefs.getString('blogPosts');
    if (postsJson != null && postsJson.isNotEmpty) {
      try {
        List<dynamic> postsList = jsonDecode(postsJson);
        setState(() {
          blogPosts = postsList.map((item) => BlogPost.fromJson(item)).toList();
        });
      } catch (e) {
        print('Error loading blog posts: $e');
      }
    }
  }

  void _saveBlogPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> postsJson =
        blogPosts.map((post) => post.toJson()).toList();
    prefs.setString('blogPosts', jsonEncode(postsJson));
  }

  void _addNewBlogPost(BlogPost post) {
    setState(() {
      blogPosts.add(post);
      _saveBlogPosts();
    });
  }

  void _navigateToAddBlogPostPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBlogPostPage(
          onAdd: _addNewBlogPost,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BlogPost> filteredPosts = selectedCategory == 'Trend'
        ? blogPosts
        : blogPosts.where((post) {
            return post.categories.contains(selectedCategory);
          }).toList();

    return Scaffold(
      appBar: CustomAppBar(
        imageUrl: 'https://picsum.photos/200/300',
        onPressed: _navigateToAddBlogPostPage,
        showAddButton: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['label'];
                      });
                    },
                    child: CategoryItem(
                      label: category['label'],
                      icon: category['icon'],
                      isSelected: selectedCategory == category['label'],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              selectedCategory,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                BlogPost post = filteredPosts[index];
                return BlogPostCard(post: post);
              },
            ),
          ),
        ],
      ),
    );
  }
}
