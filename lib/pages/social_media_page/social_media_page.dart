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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  List<Map<String, dynamic>> categories = [
    {'label': 'Trend', 'icon': ""},
    {'label': 'Başarı', 'icon':'assets/categoryIcons/success.png'},
    {'label': 'Kariyer', 'icon': ""},
    {'label': 'Motivasyon', 'icon': ""},
    {'label': 'Gelişim', 'icon': ""},
    {'label': 'Kitaplar', 'icon': ""},
    {'label': 'Eğitim', 'icon': ""},
    {'label': 'Zaman', 'icon': ""},
    {'label': 'Hedefler', 'icon': ""},
    {'label': 'İlham', 'icon': ""},
    {'label': 'Özgüven', 'icon': ""},

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
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: BlocBuilder<Imagecubit, List<UserImageEntity>>(
                builder: (context, userImageList) {
                  String imageName;
                  if (userImageList.isNotEmpty) {
                    imageName = userImageList.first.profileIcon;
                  } else {
                    imageName = "chick";
                  }
                  return ClipOval(
                    child: SvgPicture.asset(
                      "assets/animalIcon/$imageName.svg",
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  );
                },
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






