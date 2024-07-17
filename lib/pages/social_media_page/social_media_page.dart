import 'package:flutter/material.dart';
import 'package:motix_app/pages/social_media_page/add_blog_post_page.dart';
import 'package:motix_app/pages/social_media_page/blog_post.dart';
import 'package:motix_app/pages/social_media_page/category_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  List<Map<String, dynamic>> categories = [
    {'label': 'Kültür', 'icon': Icons.ac_unit_rounded},
    {'label': 'Dizayn', 'icon': Icons.design_services},
    {'label': 'Trend', 'icon': Icons.trending_up},
    {'label': 'Tarih', 'icon': Icons.history},
    {'label': 'Gezi', 'icon': Icons.travel_explore},
  ];
  String selectedCategory = 'Trend';
  List<BlogPost> blogPosts = [];

  @override
  void initState() {
    super.initState();
    _loadBlogPosts();
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

    late String imageAbcUrl;
    setState(() {
      imageAbcUrl =
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/220px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg';
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ClipOval(
                child: Image.network(
                  imageAbcUrl,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Image.asset('assets/logo/yeniMotix.png', width: 90),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 38,
            ),
            onPressed: _navigateToAddBlogPostPage,
          ),
        ],
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






